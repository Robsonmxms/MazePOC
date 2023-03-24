//
//  GameScene.swift
//  MazePoc
//
//  Created by Robson Lima Lopes on 23/03/23.
//

import SpriteKit

class GameScene: SKScene {
    private let brickWidth: CGFloat = 40

    override func didMove(to view: SKView) {

        let maze: Maze = Maze(size: size, brickWidth: brickWidth)

        let floor: [CGPoint] = maze.getFloor()

        let wallBricksAsNodes: [SKSpriteNode] = maze.getWallsAsSKSpriteNode()

        for wallBrick in wallBricksAsNodes {
            addChild(wallBrick)
        }

        let boyAsCircle = buildCircle(color: .blue, position: floor.randomElement()!)
        addChild(boyAsCircle)

        let MomAsCircle = buildCircle(color: .red, position: floor.randomElement()!)
        addChild(MomAsCircle)

        let DollAsCircle = buildCircle(color: .white, position: floor.randomElement()!)
        addChild(DollAsCircle)

        backgroundColor = .black
    }

    func buildCircle(color: UIColor, position: CGPoint) -> SKShapeNode {
        let circle = SKShapeNode(circleOfRadius: brickWidth/2)
        circle.fillColor = color
        circle.position = position

        return circle
    }
}

