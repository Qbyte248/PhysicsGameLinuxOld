//
//  main.swift
//  PhysicsGame
//
//  Created by Maximilian Hünenberger on 7.8.16.
//  Copyright © 2016 MaHue. All rights reserved.
//

import Foundation

print("Hello, World!")

func shell(_ launchPath: String = "/usr/bin/env", args: String...) {
	let task = Task()
	task.launchPath = launchPath
	task.arguments = args
	task.launch()
	task.waitUntilExit()
}
/*

shell(args: "killall", "java")
shell(args: "java", "-cp", pathToWorkingDirectory, "PhysicsGame/Java/DrawingServer")
*/
/*InputStream.getStreamsToHost(withName: "localhost",
                             port: 1234,
                             inputStream: nil,
                             outputStream: &Stream.output)

outputStream?.open()*/
Stream.output = SwiftJavaWrapper(pathToWorkingDirectory: "/home/maxi/Documents/PhysicsGame/")
Stream.input = Stream.output
Stream.error = Stream.input

//shell(args: "java", "-cp", pathToWorkingDirectory, "PhysicsGame/Java/WorkaroundStreamer", command.convertToString())


//var distr = CommandDistributor(inputStream: Stream.input!)


class Interpreter: CommandInterpreter {

	func interpretCommand(_ command: Command) {
		switch command.getCommandString() {
		case Protocol.Server.mousePosition:
			var v = Vector2D(0,0)
			try! v.convertFromObject(command.getParameterValueForKey(Protocol.Key.mousePosition))
			mouseMoved(position: v)
		default:
			break
		}
	}

	func finishedInterpretingCommands() -> Bool {
		return false
	}

}

//distr.addCommandInterpreter(Interpreter())

/*
DispatchQueue.global().async {
	while true {
		print()
		print(Stream.error?.readError())
		print()
	}
}*/

setup()
while Program.isRunning {
	let time = 1 / Program.framesPerSecond
	usleep(UInt32(time * 1000000))
	run()
	world.update(time: time)
	world.repaint()
}

print("finished Swift")
