//
//  Circle.swift
//  MazePoc
//
//  Created by Robson Lima Lopes on 24/03/23.
//

import SpriteKit

class CircleNode: SKShapeNode {

    init(radius: CGFloat, position: CGPoint, color: UIColor) {
        super.init()

        self.position = position

        let circle = CGPath(ellipseIn: CGRect(x: -radius, y: -radius, width: radius*2, height: radius*2), transform: nil)

        self.path = circle
        self.fillColor = color
        self.strokeColor = .clear

        // Configuração da física do nó do círculo
        self.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.categoryBitMask = 1
        self.physicsBody?.collisionBitMask = 1
        self.physicsBody?.contactTestBitMask = 1
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
