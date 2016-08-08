//
//  Block.swift
//  PhysicsGame
//
//  Created by Maximilian Hünenberger on 7.8.16.
//  Copyright © 2016 MaHue. All rights reserved.
//

import Foundation

final class Block {
	
	private(set) var physicsBody: PhysicsBody
	
	var position: Point {
		get { return physicsBody.position }
		set { physicsBody.position = newValue }
	}
	
	var size: Size {
		get { return physicsBody.size }
		set { physicsBody.size = newValue }
	}
	
	var color: Color
	
	init(position: Point,
	     size: Size,
	     color: Color = Color(red: 0, green: 0, blue: 0, alpha: 1)) {
		
		self.physicsBody = PhysicsBody(position: position,
		                               size: size,
		                               mass: 1)
		
		self.color = color
		
		physicsBody.position = position
		physicsBody.size = size
		
	}
	
	func draw(offset: Vector2D) {
		color.draw()
		Rectangle(origin: Vector2D(position.x, position.y), size: size).draw(offset: offset)
		//physicsBody.draw()
	}
}
