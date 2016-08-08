//
//  PhysicsBody.swift
//  PhysicsGame
//
//  Created by Maximilian Hünenberger on 7.8.16.
//  Copyright © 2016 MaHue. All rights reserved.
//

import Foundation

struct PhysicsBody {
	var position: Point
	var size: Size
	
	var velocity: Vector2D
	
	var mass: Double
	var force = Vector2D(0,0)
	
	var friction: Double
	
	init(position: Point,
	     size: Size,
	     velocity: Vector2D = Vector2D(0,0),
	     mass: Double,
	     friction: Double = 0.0) {
		self.position = position
		self.size = size
		self.velocity = velocity
		self.mass = mass
		self.friction = friction
	}
	
	// FOXME: delete this function
	/*func draw() {
		Color(red: 1, green: 1, blue: 0, alpha: 1).draw()
		Rectangle(origin: Vector2D(position.x, position.y), size: size).draw()
	}*/
	
	mutating func interact(_ body: PhysicsBody, now: Bool = false) {
		guard let contactSide = self.contactSideTo(body, now: now) else {
			return
		}
		
		let force = contactSide.depth * 10
		
		if now {
			print(contactSide)
		}
		
		switch contactSide.side {
		case .left:
			//self.position.x += contactSide.depth
			self.force.x += force
			//self.velocity.x = 0
		case .right:
			//self.position.x -= contactSide.depth
			self.force.x -= force
			//self.velocity.x = 0
		case .lower:
			self.position.y += contactSide.depth
			self.force.y += force
			self.velocity.y = 0
			self.force.x -= self.velocity.x * friction
		case .upper:
			self.position.y -= contactSide.depth
			self.force.y -= force
			self.velocity.y = 0
			self.force.x -= self.velocity.x * friction
		}
	}
	
	mutating func update(time: Double, forceField: (Point) -> Vector2D) {
	
		self.position.x += time * velocity.x
		self.position.y += time * velocity.y
		
		self.force += forceField(self.position)
		self.velocity += self.force * (time / mass)
		
		self.force = Vector2D(0, 0)
	}
	
	var cornerPoints: [Point] {
		return [
			position,
			Point(x: position.x, y: position.y + size.height),
			Point(x: position.x + size.width, y: position.y),
			Point(x: position.x + size.width, y: position.y + size.height)
		]
	}
	
	func containsPoint(_ point: Point) -> Bool {
		return position.x <= point.x
			&& point.x <= position.x + size.width
			&& position.y <= point.y
			&& point.y <= position.y + size.height
	}
	
	func overlaps(_ physicsBody: PhysicsBody) -> Bool {
		return self.cornerPoints.contains{ physicsBody.containsPoint($0) }
			|| physicsBody.cornerPoints.contains{ self.containsPoint($0) }
	}
	
	struct ContactSide {
		var side: Side
		var depth: Double
		
		enum Side {
			case left, right, upper, lower
		}
	}
	
	func contactSideTo(_ physicsBody: PhysicsBody, now: Bool = false) -> ContactSide? {
		guard self.overlaps(physicsBody) else {
			return nil
		}
		
		let left = abs(physicsBody.position.x + physicsBody.size.width - self.position.x)
		let right = abs(self.position.x + self.size.width - physicsBody.position.x)
		
		let down = abs(physicsBody.position.y + physicsBody.size.height - self.position.y)
		let up = abs(self.position.y + self.size.height - physicsBody.position.y)
		
		if now {
			print(self.position, self.size)
			print(physicsBody.position, physicsBody.size)
			print(left, right, down, up)
		}
		
		let minValue = min(left, right, down, up)
		switch minValue {
		case left: return ContactSide(side: .left, depth: minValue)
		case right: return ContactSide(side: .right, depth: minValue)
		case down: return ContactSide(side: .lower, depth: minValue)
		case up: return ContactSide(side: .upper, depth: minValue)
		default:
			fatalError("min should be unique")
		}
		
	}
}
