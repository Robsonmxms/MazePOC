//
//  GameViewController.swift
//  MazePoc
//
//  Created by Robson Lima Lopes on 23/03/23.
//

import SwiftUI
import SpriteKit

struct GameView: UIViewRepresentable {

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        view.frame = UIScreen.main.bounds

        let scene = GameScene(size: view.bounds.size)
        scene.scaleMode = .resizeFill

        view.presentScene(scene)

        return view
    }

    func updateUIView(_ view: SKView, context: Context) {
        // Empty
    }

}

struct ContentView: View {
    var body: some View {
        GameView().ignoresSafeArea()
    }
}


