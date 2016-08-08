//
//  Vector2D.swift
//  Swift 3 TestProject
//
//  Created by Maximilian Hünenberger on 16.7.16.
//
//

import Foundation

struct Vector2D: ObjectConvertible {
	var x: Double
	var y: Double
	
	init(_ x: Double, _ y: Double) {
		self.x = x;
		self.y = y;
	}
	
	func add(_ vector: Vector2D) -> Vector2D {
		return Vector2D(self.x + vector.x, self.y + vector.y);
	}
	func subtract(_ vector: Vector2D) -> Vector2D {
		return Vector2D(self.x - vector.x, self.y - vector.y);
	}
	func multiply(_ scalar: Double) -> Vector2D {
		return Vector2D(self.x * scalar, self.y * scalar);
	}
	mutating func addInPlace(_ vector: Vector2D) {
		x += vector.x;
		y += vector.y;
	}
	mutating func subtractInPlace(_ vector: Vector2D) {
		x -= vector.x;
		y -= vector.y;
	}
	
	// MARK: - ObjectConvertible
	
	static func convertFromObject(_ object: Object) throws -> Vector2D {
		var vector = Vector2D(0,0)
		try vector.convertFromObject(object)
		return vector
	}
	
	mutating func convertFromObject(_ object: Object) throws {
		guard let list = Helper.castToArrayOfStrings(object) else {
			throw IllegalArgumentException("list is null")
		}
		
		if (list.count != 2) {
			throw IllegalArgumentException("list has not size == 2");
		}
		
		guard
			let x = Double(list[0]),
			let y = Double(list[1]) else {
				throw IllegalArgumentException("could not parse numbers from String")
		}
		self.x = x
		self.y = y
	}
	
	func convertToObject() -> Object {
		return .array([
			.string("\(x)"),
			.string("\(y)")
			])
	}
	
	// MARK: - Operators
	
	static func + (v1: Vector2D, v2: Vector2D) -> Vector2D {
		return v1.add(v2)
	}
	static func - (v1: Vector2D, v2: Vector2D) -> Vector2D {
		return v1.subtract(v2)
	}
	static func * (v: Vector2D, s: Double) -> Vector2D {
		return v.multiply(s)
	}
	static func * (s: Double, v: Vector2D) -> Vector2D {
		return v.multiply(s)
	}
	
	static func += ( v1: inout Vector2D, v2: Vector2D) {
		return v1.addInPlace(v2)
	}
}
