//
//  LoginViewModel.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation
import Combine

@MainActor
class CatBreedsListViewModel: ObservableObject  {
  
    private var retrieveDataService: TheCatAPIService
    private var cancellable: AnyCancellable?
    private var catBreedsImagesIds = [(String, String)]()
    
    @Published var catBreedsViewModels = [CatBreedViewModel]()
    @Published var errorRetrievingData: Bool = false
    @Published var searchTerm: String = ""
  
    var catImages = [CatImage]() {
        didSet {
            oldValue.forEach { catImage in
                for index in 0..<catBreedsViewModels.count {
                    if catImage.breedId == catBreedsViewModels[index].id {
                        catBreedsViewModels[index].imageUrl = catImage.url
                    }
                }
            }
      }
    }
    
   
    init(retrieveDataService: TheCatAPIService) {
        self.retrieveDataService = retrieveDataService
    }
    
    func retrieveData() {
    
        guard let url = URL(string: APISettings.getAllBreedsUrl + APISettings.api_keyParameter) else {
                return
            }
        
        self.cancellable = retrieveDataService.retrieveResource(url: url)
            
        .map { catBreeds in
            catBreeds.map { catBreed in
                if let imageId = catBreed.reference_image_id {
                    self.catBreedsImagesIds.append((imageId, catBreed.id))
                }
                return CatBreedViewModel(catBreed: catBreed)
            }
        }
        .sink { completion in
            switch completion {
                case .finished:
                    break
                case .failure(_):
                self.errorRetrievingData = true
            }
        } receiveValue: { catBreedsViewModels in
            self.catBreedsViewModels = catBreedsViewModels
            self.retrieveCatImages(self.catBreedsImagesIds)
            self.cancellable?.cancel()
        }

    }
    
    
    func retrieveCatImages(_ catImageIds: [(String, String)]) {
        
        for id in catImageIds {
            DispatchQueue.global(qos: .userInitiated).async() {
                
                Task {
                    do {
                        guard let url = URL(string: APISettings.getCatImage + id.0 + APISettings.api_keyParameter) else {
                                throw NetworkError.badUrl
                            }
                        
                        let catImage = try await self.retrieveDataService.retrieveImage(url: url)
                        
                        DispatchQueue.main.async() {
                            if var catImage = catImage {
                                catImage.breedId = id.1
                                self.catImages.append(catImage)
                            }
                        }
                        
                    }
                    catch {
                        print(error)
                    }
                }
      
        
            }
        }
        
        
    }
    
    
    
}



