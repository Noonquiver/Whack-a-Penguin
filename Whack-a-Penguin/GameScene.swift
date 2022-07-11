//
//  GameScene.swift
//  Whack-a-Penguin
//
//  Created by Camilo Hernández Guerrero on 10/07/22.
//

import SpriteKit

class GameScene: SKScene {
    var slots = [WhackSlot]()
    var gameScore: SKLabelNode!
    var score = 0 {
        didSet {
            gameScore.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "whackBackground")
        background.position = CGPoint(x: 512, y: 384)
        background.zPosition = -1
        background.blendMode = .replace
        addChild(background)
        
        gameScore = SKLabelNode(fontNamed: "Chalkluster")
        gameScore.text = "Score: 0"
        gameScore.position = CGPoint(x: 8, y: 8)
        gameScore.horizontalAlignmentMode = .left
        gameScore.fontSize = 48
        addChild(gameScore)
        
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + i * 170, y: 410)) }
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + i * 170, y: 320)) }
        for i in 0..<5 { createSlot(at: CGPoint(x: 100 + i * 170, y: 230)) }
        for i in 0..<4 { createSlot(at: CGPoint(x: 180 + i * 170, y: 140)) }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
    
    func createSlot(at position: CGPoint) {
        let slot = WhackSlot()
        slot.configure(at: position)
        addChild(slot)
        slots.append(slot)
    }
}
