//
//  File.swift
//  MazePoc
//
//  Created by Robson Lima Lopes on 23/03/23.
//

import SpriteKit

class Maze {
    private var walls: [CGPoint] = []
    private var floor: [CGPoint] = []
    private let brickWidth: CGFloat
    private let size: CGSize

    init(size: CGSize, brickWidth: CGFloat){
        self.size = size
        self.brickWidth = brickWidth
        buildGrid()
    }

    private func buildGrid() {
        for column in stride(from: brickWidth/2, to: size.height, by: brickWidth) {
            for row in stride(from: brickWidth/2, to: size.width, by: brickWidth) {
                walls.append(CGPoint(x: row, y: column))
            }
        }

        while Double(floor.count/walls.count)<0.95 {
            if floor.isEmpty {
                buildFloor(startPoint: walls.randomElement()!)
            } else {
                buildFloor(startPoint: floor.randomElement()!)
            }

        }
    }

    private func buildFloor(startPoint: CGPoint) {

        let topPoint = CGPoint(
            x: startPoint.x + brickWidth,
            y: startPoint.y
        )

        let leadingPoint = CGPoint(
            x: startPoint.x,
            y: startPoint.y - brickWidth
        )

        let trailingPoint = CGPoint(
            x: startPoint.x,
            y: startPoint.y + brickWidth
        )

        let bottomPoint = CGPoint(
            x: startPoint.x - brickWidth,
            y: startPoint.y
        )

        let availablePoints: [CGPoint] = getAvailablePoints(points: [
            topPoint, leadingPoint, trailingPoint, bottomPoint
        ])

        if !availablePoints.isEmpty {
            guard let point = availablePoints.randomElement() else {
                fatalError("point isn't available")
            }
            buildBrick(point: point)
        }
    }

    private func buildBrick(point: CGPoint) {
        walls.removeAll { $0 == point}
        floor.append(point)
        buildFloor(startPoint: point)
    }

    private func getAvailablePoints(points: [CGPoint]) -> [CGPoint] {
        var availablePoints: [CGPoint] = []

        for point in points {
            if walls.contains(point) {
                availablePoints.append(point)
            }
        }

        return availablePoints
    }

    func getFloor() -> [CGPoint] {
        return floor
    }

    func getWalls() -> [CGPoint] {
        return walls
    }

    func getWallsAsSKSpriteNode() -> [SKSpriteNode]{

        var spriteNodes: [SKSpriteNode] = []

        for point in walls {
            let wallBrick = SKSpriteNode(
                color: .gray,
                size: CGSize(width: brickWidth, height: brickWidth)
            )

            wallBrick.position = point

            wallBrick.physicsBody = SKPhysicsBody(rectangleOf: wallBrick.size)
            wallBrick.physicsBody?.isDynamic = false
            spriteNodes.append(wallBrick)
        }

        return spriteNodes
    }
}
