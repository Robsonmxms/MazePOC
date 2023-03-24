//
//  AppDelegate.swift
//  MazePoc
//
//  Created by Robson Lima Lopes on 23/03/23.
//

import SwiftUI

@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }.navigationViewStyle(StackNavigationViewStyle())

        }
    }

}

