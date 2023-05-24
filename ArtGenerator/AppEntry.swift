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
                    Task {
                        let sample = GenerationInput(prompt: "Man in a rowboat")
                        if let data = sample.encodedData {
                            try await APIService().fetchImages(with: data)
                        }
                    }
                }
        }
    }
}
