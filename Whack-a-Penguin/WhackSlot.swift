//
//  WhackSlot.swift
//  Whack-a-Penguin
//
//  Created by Camilo Hernández Guerrero on 10/07/22.
//

import SpriteKit

class WhackSlot: SKNode {
    var charNode: SKSpriteNode!
    var isVisible = false
    var isHit = false
    
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
    
    func show(hideTime: Double) {
        if isVisible { return }
        
        charNode.xScale = 1
        charNode.yScale = 1
        
        let mud = createMud()
        let show = SKAction.moveBy(x: 0, y: 80, duration: 0.05)
        let sequence = SKAction.sequence([mud, show])
        charNode.run(sequence)
        
        isVisible = true
        isHit = false
        
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + hideTime * 3.5) {
            [weak self] in
            self?.hide()	
        }
    }
    
    func hide() {
        if !isVisible { return }
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true

        let delay = SKAction.wait(forDuration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run {
            [weak self] in
            self?.isVisible = false
        }
        
        let mud = createMud()
        let smoke = SKAction.run {
            [weak self] in
            guard let smoke = SKEmitterNode(fileNamed: "Smoke") else { return }
            
            if let charPosition = self?.charNode.position {
                smoke.position = charPosition
                self?.charNode.addChild(smoke)
            }
        }

        
        let sequence = SKAction.sequence([delay, smoke, hide, mud, notVisible])
        charNode.run(sequence)
    }
    
    func createMud() -> SKAction {
        let action = SKAction.run {
            [weak self] in
            guard let mud = SKEmitterNode(fileNamed: "Mud") else { return }

            if let charPosition = self?.charNode.position {
                mud.position = charPosition
                mud.xScale = 0.6
                mud.yScale = 0.6
                mud.particleLifetime = 0.1
                self?.charNode.addChild(mud)
            }
        }
        
        return action
    }
}
