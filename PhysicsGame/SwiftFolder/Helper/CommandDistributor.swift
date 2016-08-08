
import Foundation

/*
extension InputStream {
	func read() -> UInt8? {
		var buffer = [UInt8]()
		guard self.read(&buffer, maxLength: 1) == 1 else {
			return nil
		}
		return buffer[0]
	}
}*/

/**
* Distributes Commands from an InputStream to CommandInterpreters
* which can be added for logging with "self.addCommandInterpreter(...)"
*/
/// Is a pseudo thread
public class CommandDistributor {


	private var inputStream: InputStream;
	private var commandInterpreters = Array<CommandInterpreter>();

	private var shouldStop = false;

	/**
	* @param inputStream from which commands get interpreted
	*/
	public init(inputStream: InputStream) {
		self.inputStream = inputStream;

		// start thread
		self.start();
	}

	public func start() {
		print("ruuuuuuuuun")

		//DispatchQueue.global().async {
			self.run()
		//}
	}

	/**
	* notifies all command interpreters that they won't receive commands anymore
	* and removes them from the list of command interpreters
	*/
	// sync
	public func removeAllCommandInterpreters() {
		for commandInterpreter in commandInterpreters {
			commandInterpreter.willFinishInterpretingCommands();
		}
		commandInterpreters.removeAll();
	}

	/**
	* calls removeAllCommandInterpretes and stops reading from inputStream
	*/
	// sync
	public func stopThread() {
		removeAllCommandInterpreters();
		shouldStop = true;
	}

	/**
	* adds commandInterpeter to list of command interpreters
	* @param commandInterpreter which gets added
	*/
	// sync
	public func addCommandInterpreter(_ commandInterpreter: CommandInterpreter) {
		commandInterpreters.append(commandInterpreter);
	}


	public func run() {

		var commandString = "";
		print("started command interpreter")

		// !!! can throw IOException
		while let c = inputStream.readChar() {

			//print(c, terminator: "")

			// execute in main.sync
			//DispatchQueue.global().sync {

				if (self.shouldStop) {
					// stop thread
					return;
				}

				commandString.append(c)
				//commandString.append(String(UnicodeScalar(c)));

				// sort out commandInterpreters which don't read commands
				var i = 0
				while i < self.commandInterpreters.count {
					if (self.commandInterpreters[i].finishedInterpretingCommands()) {
						self.commandInterpreters.remove(at: i);
						i -= 1
					}
					i += 1
				}

				if (Command.stringEndsWithEndDelimiter(commandString)) {

					do {
						// !!! can throw IllegalArgumentException
						let command = try Command.fromString(commandString)

						// pass command to all commandInterpreters
						for commandInterpreter in self.commandInterpreters {
							commandInterpreter.interpretCommand(command);
						}

						// reset commandString
						commandString = "";
					} catch {
						// continue reading from input Stream and reset command String
						commandString = ""
					}

				//}
			}
		}

		//DispatchQueue.main.sync {

			commandInterpreters.forEach{
				$0.willFinishInterpretingCommands();
			}

			commandInterpreters.removeAll()
		//}
	}

}
