//
//  Program.swift
//  PhysicsGame
//
//  Created by Maximilian Hünenberger on 7.8.16.
//  Copyright © 2016 MaHue. All rights reserved.
//

import Foundation

struct Program {
	
	static var world = World()
	
	static var framesPerSecond = 30.0
	
	private(set) static var isRunning = true
	static func stop() {
		isRunning = false
	}
}

var world: World {
	get { return Program.world }
	set { Program.world = newValue }
}
