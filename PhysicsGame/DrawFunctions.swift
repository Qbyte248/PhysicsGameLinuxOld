//
//  DrawFunctions.swift
//  PhysicsGame
//
//  Created by Maximilian Hünenberger on 7.8.16.
//  Copyright © 2016 MaHue. All rights reserved.
//

import Foundation


enum Stream {
	static var output: OutputStream?
	static var input: InputStream?
	static var error: SwiftJavaWrapper?
}

var outputStream: OutputStream? {
	return Stream.output
}

public struct Draw {
	static func clear() {
		let command = try! Command(Protocol.Client.clear)
		try! command.sendWithOutputStream(outputStream!)
	}
	static func repaint(always: Bool? = nil) {
		var command = try! Command(Protocol.Client.repaint)
		if let always = always {
			command.addParameter(Protocol.Key.always, String(always))
		}
		try! command.sendWithOutputStream(outputStream!)
	}

	static func rect(_ rectangle: Rectangle) {
		var command = try! Command(Protocol.Client.rectangle)
		command.addParameter(Protocol.Key.rectangle, rectangle.convertToObject())
		try! command.sendWithOutputStream(outputStream!)
	}
	static func rect(_ x: Double, _ y: Double, _ width: Double, _ height: Double) {
		Draw.rect(Rectangle(x, y, width, height))
	}
	static func color(_ color: Color) {
		var command = try! Command(Protocol.Client.color)
		command.addParameter(Protocol.Key.color, color.convertToObject())
		try! command.sendWithOutputStream(outputStream!)
	}
	static func color(red: Double, green: Double, blue: Double, alpha: Double) {
		Draw.color(Color(red: red, green: green, blue: blue, alpha: alpha))
	}
	static func line(_ line: Line) {
		var command = try! Command(Protocol.Client.line)
		command.addParameter(Protocol.Key.line, line.convertToObject())
		try! command.sendWithOutputStream(outputStream!)
	}
	static func line(_ x1: Double, _ y1: Double, _ x2: Double, _ y2: Double) {
		let lineResult = Line(start: Vector2D(x1, y1), end: Vector2D(x2, y2))
		Draw.line(lineResult)
	}
	static func polygon(points: (x: Double, y: Double)...) {
		var resultPpolygon = Polygon()
		for (x, y) in points {
			resultPpolygon.append(Vector2D(x, y))
		}

		Draw.polygon(resultPpolygon)
	}
	static func polygon(_ polygon: Polygon) {
		var command = try! Command(Protocol.Client.polygon)
		command.addParameter(Protocol.Key.polygon, polygon.convertToObject())
		try! command.sendWithOutputStream(outputStream!)
	}
}
