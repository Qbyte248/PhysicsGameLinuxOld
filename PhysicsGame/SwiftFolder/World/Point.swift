//
//  Point.swift
//  Swift 3 TestProject
//
//  Created by Maximilian Hünenberger on 27.7.16.
//
//

import Foundation

struct Point: Equatable {
	var x: Double
	var y: Double
	
	// MARK: - Equatable
	
	static func == (p1: Point, p2: Point) -> Bool {
		return p1.x == p2.x && p1.y == p2.y
	}
}
