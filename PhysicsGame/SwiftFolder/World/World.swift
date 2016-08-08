//
//  World.swift
//  Swift 3 TestProject
//
//  Created by Maximilian Hünenberger on 27.7.16.
//
//

import Foundation

final class World {
	
	var position = Point(x: 0, y: 0)
	
	var items = [Item]()
	var blocks = [Block]()
	
	var backgrounds = [Texture]()
	
	init() {}
	
	func addItem(_ item: Item) {
		self.items.append(item)
	}
	
	func addBlock(_ block: Block) {
		self.blocks.append(block)
	}
	
	/// simulates physics
	func update(time: Double) {
		for item in items {
			for otherItem in items where item !== otherItem {
				item.interact(otherItem)
			}
			for block in blocks {
				item.interact(block)
			}
		}
		for item in items {
			item.update(time: time, forceField: { _ in Vector2D(0, -1000) })
		}
		
	}
	
	func repaint() {
		
		Draw.clear()
		
		// TODO: draw code
		
		for i in backgrounds.indices.reversed() {
			let background = backgrounds[i]
			background.draw(offset: Vector2D(-self.position.x / Double(i + 1), 0))
		}
		
		let offset = Vector2D(self.position.x, self.position.y)
		for block in blocks {
			block.draw(offset: offset)
		}
		
		for item in items {
			item.draw(offset: offset)
		}
		
		Draw.repaint()
	}
}
