//
//  DogViewModel.swift
//  DogBreedsImages
//
//  Created by Bhavani Reddy Navure on 5/2/23.
//

import Foundation
import Combine
import SwiftUI

class DogViewModel: ObservableObject {
    private var apiManager: APIManager?
    @Published var breeds: [Breed] = []
    @Published var currentBreedIndex = 0
    @Published var offset: CGFloat = 0

    var errorMessage: String?


    init() {
        self.apiManager = APIManager()
        fetchBreeds()
    }
    
    var selectedBreed: Breed? {
        breeds.first(where: { $0.isSelected })
    }
    
       
    var currentBreed: Breed? {
        guard currentBreedIndex < breeds.count else { return nil }
       
        return breeds[currentBreedIndex]
    }
    
   
    
    var currentBreedName: String {
        currentBreed?.name ?? ""
    }
    
    var currentBreedDescription: String {
        currentBreed?.bredFor ?? ""
    }
    
    var currentBreedLifeSpan: String {
        currentBreed?.lifeSpan ?? ""
    }

    func showNextBreed() {
        if currentBreedIndex < breeds.count - 1 {
            currentBreedIndex += 1
            fetchBreeds()
        }
    }
    
    func showPreviousBreed() {
        currentBreedIndex = max(currentBreedIndex - 1, 0)
    }
    
    func fetchBreeds() {
        apiManager?.getDogs { [weak self] breeds in
                DispatchQueue.main.async {
                    if let breeds = breeds {
                        self?.breeds = breeds
                    } else {
                        self?.errorMessage = "Unable to fetch breeds"
                    }
                }
            }
        }
    
    func selectBreed(_ breed: Breed) {
        if let index = breeds.firstIndex(where: { $0.id == breed.id }) {
            deselectAllBreeds() // Deselect all breeds before selecting a new one
            breeds[index].isSelected = true // Select the breed
        }
    }

    func deselectAllBreeds() {
        breeds.indices.forEach { breeds[$0].isSelected = false }
    }
    
    @Published var swipeCard = 0
//    Detail Content...
    @Published var showCard = false
    @Published var showContent = false


}






