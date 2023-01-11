//
//  CatBreedViewModel.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 11.01.2023.
//

import Foundation


struct CatBreedViewModel {
    
    let catBreed: CatBreed
  
    var imageUrl: String = ""
    
    var id: String {
         self.catBreed.id
    }
    
    var name: String {
         self.catBreed.name
    }
    
    var description: String {
         self.catBreed.description
    }
    
    var countryCode: String {
         self.catBreed.country_code
    }
    
    var country: String {
        self.catBreed.origin.lowercased()
    }
    
    var wikipediaUrl: String {
        self.catBreed.wikipedia_url ?? "not available"
    }

    var imageId: String? {
        self.catBreed.reference_image_id ?? nil
    }

    var temperament: String {
        self.catBreed.temperament ?? "not available"
    }
 
    
}
