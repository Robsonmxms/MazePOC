//
//  GameScene.swift
//  MazePoc
//
//  Created by Marcelo De Araújo on 29/03/23.
//

import SpriteKit
import CoreMotion
import SceneKit

class GameScene: SKScene, SKPhysicsContactDelegate {

    private var manager: CMMotionManager? = CMMotionManager()
    private var timer: Timer?
    internal var seconds: Double?

    private let brickWidth: CGFloat = 30

    lazy var boyAsSphere = SK3DNode(viewportSize: CGSize(width: 30, height: 30))
    lazy var monAsSphere = SK3DNode(viewportSize: CGSize(width: 30, height: 30))
    lazy var dollAsSphere = SK3DNode(viewportSize: CGSize(width: 30, height: 30))

    override func didMove(to view: SKView) {

        physicsWorld.contactDelegate = self

        let frameAdjusted = CGRect(
            x: frame.origin.x,
            y: frame.origin.y,
            width: self.frame.width,
            height: self.frame.height
        )
        physicsBody = SKPhysicsBody(edgeLoopFrom: frameAdjusted)

        if let manager = manager, manager.isDeviceMotionAvailable {
            manager.deviceMotionUpdateInterval = 0.01
            manager.startDeviceMotionUpdates()
        }

        timer = Timer.scheduledTimer(
            timeInterval: 0.01,
            target: self,
            selector: #selector(increaseTimer),
            userInfo: nil,
            repeats: true
        )

        let maze: Maze = Maze(
            size: size,
            brickWidth: brickWidth,
            floorWallsProportion: 0.1
        )

        let floor: [CGPoint] = maze.getFloor()

        let wallBricksAsNodes: [SKSpriteNode] = maze.getWallsAsSKSpriteNode()

        for wallBrick in wallBricksAsNodes {
            addChild(wallBrick)
        }

        let boyPositionX = floor.randomElement()!

        boyAsSphere.scnScene = SCNScene()
        boyAsSphere.scnScene?.rootNode.addChildNode(SphereNode3D(color: .blue) as SCNNode)
        boyAsSphere.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(boyAsSphere)

        monAsSphere.scnScene = SCNScene()
        monAsSphere.scnScene?.rootNode.addChildNode(SphereNode3D(color: .red) as SCNNode)
        monAsSphere.position = CGPoint(x: frame.midX - 30, y: frame.midY - 30)
        addChild(monAsSphere)

        dollAsSphere.scnScene = SCNScene()
        dollAsSphere.scnScene?.rootNode.addChildNode(SphereNode3D(color: .white) as SCNNode)
        dollAsSphere.position = CGPoint(x: frame.midX - 50, y: frame.midY - 50)
        addChild(dollAsSphere)

        let background = SKSpriteNode(imageNamed: "floor")
        background.position = CGPoint(x: size.width, y: size.height)
        background.zPosition = -1
        addChild(background)

    }

    func didBegin(_ contact: SKPhysicsContact) {
        let bodyA = contact.bodyA.node
        let bodyB = contact.bodyB.node

        // Verifique se a boyAsCircle tocou na dollAsCircle
        if (bodyA == boyAsSphere && bodyB == dollAsSphere) || (bodyA == dollAsSphere && bodyB == boyAsSphere) {
            let alert = UIAlertController(title: "Vc pegou a boneca", message: "Parabéns!", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }

        // Verifique se a momAsCircle tocou na boyAsCircle
        if (bodyA == monAsSphere && bodyB == boyAsSphere) || (bodyA == boyAsSphere && bodyB == monAsSphere) {
            let alert = UIAlertController(title: "Mamãe ti pegou", message: "Perdeu", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }

        // Verifique se a momAsCircle tocou na dollAsCircle
        if (bodyA == monAsSphere && bodyB == dollAsSphere) || (bodyA == dollAsSphere && bodyB == monAsSphere) {
            let alert = UIAlertController(title: "Mamãe pegou a boneca", message: "Vc voltará ao inicio", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(action)
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
            return
        }
    }

    override func update(_ currentTime: TimeInterval) {
        if let gravityX = manager?.deviceMotion?.gravity.y,
           let gravityY = manager?.deviceMotion?.gravity.x
           {
            boyAsSphere.physicsBody?.applyImpulse(CGVector(dx: CGFloat(-gravityX)*150, dy: CGFloat(gravityY)*150))
            monAsSphere.physicsBody?.applyImpulse(CGVector(dx: CGFloat(-gravityX)*150, dy: CGFloat(gravityY)*150))
            dollAsSphere.physicsBody?.applyImpulse(CGVector(dx: CGFloat(-gravityX)*150, dy: CGFloat(gravityY)*150))
        }

    }

    @objc func increaseTimer() {
        seconds = (seconds ?? 0.0) + 0.01
    }
}

