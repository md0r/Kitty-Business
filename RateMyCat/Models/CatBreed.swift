//
//  Breed.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation

struct CatBreed: Decodable {
    
    let id: String
    let name: String
    let description: String
    let country_code: String
    let origin: String
    let wikipedia_url: String?
    let reference_image_id: String?
    let temperament: String?
    
}
