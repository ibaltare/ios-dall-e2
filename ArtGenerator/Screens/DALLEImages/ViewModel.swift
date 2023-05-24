//
//  ViewModel.swift
//  ArtGenerator
//
//  Created by Nicolas on 23/05/23.
//

import SwiftUI

@MainActor
class ViewModel: ObservableObject {
    @Published var prompt = ""
    @Published var urls: [URL] = []
    @Published var dalleImages: [DalleImage] = []
    @Published var fetching = false
    
    let apiService = APIService()
    
    func clearProperties(){
        urls = []
        dalleImages.removeAll()
        for _ in 1...Constants.n {
            dalleImages.append(DalleImage())
        }
    }
    
    init() {
        clearProperties()
    }
    
    func fetchImages() {
        clearProperties()
        withAnimation {
            fetching.toggle()
        }
        
        let generationInput = GenerationInput(prompt: prompt)
        Task {
            if let data = generationInput.encodedData {
                do {
                    let response = try await apiService.fetchImages(with: data)
                    for data in response.data {
                        urls.append(data.url)
                    }
                    withAnimation {
                        fetching.toggle()
                    }
                    for (index, url) in urls.enumerated() {
                        dalleImages[index].uiImage = await apiService.loadImage(at: url)
                    }
                } catch {
                    print(error.localizedDescription)
                    fetching.toggle()
                }
            }
        }
    }
}
