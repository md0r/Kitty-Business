//
//  LoginViewModel.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation
import Combine


class CatBreedsListViewModel: ObservableObject  {
  
    private var retrieveDataService: TheCatAPIService
    private var cancellable: AnyCancellable?
    private var catBreedsImagesIds = [(String, String)]()
    
    @Published var catBreedsViewModels = [CatBreedViewModel]()
    @Published var errorRetrievingData: Bool = false
    @Published var searchTerm: String = ""
  
    var catImages = [CatImage]() {
        didSet {
            
            if let latestAddedElement = catImages.last {
                for index in 0..<catBreedsViewModels.count {
                    if latestAddedElement.breedId == catBreedsViewModels[index].id {
                        catBreedsViewModels[index].imageUrl = latestAddedElement.url
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
                    //we can handle errors better here in case you want to tell the user a certain image has not loaded --> currently I have a default teal placeholder for images that do not load
                        print(error)
                    }
                }
      
        }
        
        
    }
    
    
    
}



