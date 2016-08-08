import Foundation

public class SwiftJavaWrapper {

	private let task = Task()
	private let input = Pipe()
	private let output = Pipe()
	private let err = Pipe()

	init(pathToWorkingDirectory : String) {
		// start java program
		shell(args: "killall", "java")
		let args = ["java", "-cp", pathToWorkingDirectory, "PhysicsGameLinux/Java/DrawingServer"]
		task.launchPath = "/usr/bin/env"
		task.arguments = args//["java", "-jar", pathToJar]
		task.standardInput = input
		task.standardOutput = output
		task.standardError = err
		task.launch()
		//task.waitUntilExit()
	}

	func write(string: String) {
		//print(string)
		/*DispatchQueue.main.async {
			print(self.read())
		}*/
		//print("start writr")
		//DispatchQueue.main.sync {
		self.input.fileHandleForWriting.write(string.data(using: .utf8)!)
		//}
		//print("end write")
	}

	var charBuffer = [Character]()

	func readChar() -> Character? {
		if charBuffer.isEmpty {
			//self.charBuffer += Array(self.read().characters)
		}
		return charBuffer.removeFirst()
	}

	func read() -> String {
		return String(data: output.fileHandleForReading.availableData, encoding: .utf8)!
	}

	func readError() -> String {
		return String(data: err.fileHandleForReading.availableData, encoding: .utf8)!
	}

}
