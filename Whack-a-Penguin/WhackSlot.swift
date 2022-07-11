//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Camilo Hernández Guerrero on 10/07/22.
//

import SpriteKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    
    func configure(at position: CGPoint) {
        self.position = position
        
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackMask")
        
        charNode = SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        cropNode.name = "character"
        cropNode.addChild(charNode)
        
        addChild(cropNode)
    }
}
