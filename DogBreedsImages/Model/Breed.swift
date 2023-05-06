//
//  Breed.swift
//  DogBreedsImages
//
//  Created by Bhavani Reddy Navure on 5/2/23.
//

import Foundation
import SwiftUI
struct Breed: Codable {
    let id: Int
    let name: String
    let countryCode: String?
    let bredFor: String?
    let breedGroup: String?
    let lifeSpan: String?
    let temperament: String?
    let origin: String?
    var image: Image?
    
    var offset: CGFloat = 0
    var color: Color = .purple // Add a default value for color

    var isSelected: Bool = false // Add a new property to track selection status
     enum CodingKeys: String, CodingKey {
        
        case id, name, temperament, origin, image
        case breedGroup = "breed_group"
        case bredFor = "bred_for"
        case countryCode = "country_code"
        case lifeSpan = "life_span"
    }

    
    struct Image: Codable {
        let id: String
        let url: String
        var data: Data? // Add a `data` property to hold the image data

    }
}
