//
//  ArtGeneratorApp.swift
//  ArtGenerator
//
//  Created by Nicolas on 23/05/23.
//

import SwiftUI

@main
struct AppEntry: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    print(Bundle.main.infoDictionary?["API_KEY"] as? String)
                }
        }
    }
}
