//
//  TheCatAPIService.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation
import Combine


protocol TheCatAPIService  {
    
    func retrieveResource(url: URL)  ->  AnyPublisher<[CatBreed], Error>
    func retrieveImage(url: URL) async throws -> CatImage?
    
 
    
}
