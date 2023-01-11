//
//  RetrieveCatBreedsService.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation
import Combine

class RetrieveCatBreedsService: TheCatAPIService {
   
    func retrieveImage(url: URL) async throws -> CatImage? {
        
        let request = URLRequest(url: url)
    
        let (data,response) =  try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidServerResponse
        }
        
        guard let catImage: CatImage = try? JSONDecoder().decode(CatImage.self, from: data) else {
            return nil
        }
        
        return catImage
        
    }
    
   
    func retrieveResource(url: URL) -> AnyPublisher<[CatBreed], Error> {

        return URLSession.shared.dataTaskPublisher(for: url)
            .receive(on: RunLoop.main)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                    httpResponse.statusCode == 200 else {
                        throw NetworkError.invalidServerResponse
                }
                return data
            }
            .decode(type: [CatBreed].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()

    }
    
  
}
