//
//  GameScene.swift
//  MazePoc
//
//  Created by Robson Lima Lopes on 23/03/23.
//

import SpriteKit

class GameScene: SKScene {
    private let brickWidth: CGFloat = 30

    override func didMove(to view: SKView) {

        let maze: Maze = Maze(size: size, brickWidth: brickWidth)

        let floor: [CGPoint] = maze.getFloor()

        let wallBricksAsNodes: [SKSpriteNode] = maze.getWallsAsSKSpriteNode()

        for wallBrick in wallBricksAsNodes {
            addChild(wallBrick)
        }

        let boyAsCircle = CircleNode(
            radius: brickWidth/2,
            position: floor.randomElement()!,
            color: .blue
        )
        addChild(boyAsCircle)

        let MomAsCircle = CircleNode(
            radius: brickWidth/2,
            position: floor.randomElement()!,
            color: .red
        )
        addChild(MomAsCircle)

        let DollAsCircle = CircleNode(
            radius: brickWidth/2,
            position: floor.randomElement()!,
            color: .white
        )
        addChild(DollAsCircle)

        backgroundColor = .black
    }
}

