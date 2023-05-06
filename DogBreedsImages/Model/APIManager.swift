//
//  APIManager.swift
//  DogBreedsImages
//
//  Created by Bhavani Reddy Navure on 5/2/23.
//
import SwiftUI
import Foundation
struct APIManager {
    static let colors: [Color] = [Color("purple"), Color("berry"), .yellow, Color("green"), .orange] // Define an array of colors

    
    static var jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .useDefaultKeys
        return jsonDecoder
    }()
    
    func getDogs(completion: @escaping ([Breed]?) -> Void) {
        guard let url = URL(string: "https://api.thedogapi.com/v1/breeds") else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            do {
                var breeds = try APIManager.jsonDecoder.decode([Breed].self, from: data)
                
                for (index, var breed) in breeds.enumerated() {
                    let colorIndex = index % APIManager.colors.count
                    breed.color = APIManager.colors[colorIndex]
                    breeds[index] = breed
                }
                
                // Fetch the image for each breed
                for i in 0..<breeds.count {
                    if let imageUrl = breeds[i].image?.url {
                        self.fetchImage(imageUrl) { data in
                            breeds[i].image?.data = data // Update the `data` property with the fetched image data
                            completion(breeds)
                        }
                    }
                }
                
                // If there are no images to fetch, complete with the breeds array
                if breeds.allSatisfy({ $0.image == nil }) {
                    completion(breeds)
                }
            } catch {
                completion(nil)
            }
        }.resume()
    }
    
    private func fetchImage(_ imageUrl: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: imageUrl) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            completion(data)
        }.resume()
    }
}
