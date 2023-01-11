//
//  CatBreedDetailView.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 11.01.2023.
//

import SwiftUI

struct CatBreedDetailView: View {
    
    let catBreed: CatBreedViewModel
    
    var body: some View {
        
        ScrollView(.vertical) {
        
            HStack(alignment: .center) {
                
                AsyncImage(url: URL(string: catBreed.imageUrl)) { image in
                     image.resizable()
                          .scaledToFill()
                          .frame(width: 120, height: 120)
                          .clipShape(Rectangle())
                 } placeholder: {
                     Rectangle().fill(Color.teal)
                         .frame(width: 120, height: 120)
                 }
                 .frame(width: 120, height: 120)
                
                
                VStack(alignment: .leading, spacing: 5) {
                     Text(catBreed.name)
                         .font(.title3)
                         .foregroundColor(Color.teal)
                         .frame(maxWidth: .infinity, alignment: .leading)
                     Text("Country code: \(catBreed.countryCode)")
                            .foregroundColor(Color(uiColor: UIColor.darkGray))
                            .frame(maxWidth: .infinity, alignment: .leading)
                 }
                .padding(.leading, 10)

            }
            
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Temperament:")
                    .font(.headline)
                    .foregroundColor(Color.teal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(catBreed.temperament)
                    .foregroundColor(Color(uiColor: UIColor.darkGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 10)
      
            VStack(alignment: .leading, spacing: 5) {
                Text("Description:")
                    .font(.headline)
                    .foregroundColor(Color.teal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(catBreed.description)
                    .foregroundColor(Color(uiColor: UIColor.darkGray))
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.top, 10)
            
            if let wikipediaURL = catBreed.wikipediaUrl {
                VStack(alignment: .leading, spacing: 5) {
                    Text("More information:")
                        .font(.headline)
                        .foregroundColor(Color.teal)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Link(wikipediaURL, destination: URL(string: wikipediaURL)!)
                        .foregroundColor(Color(uiColor: UIColor.systemBlue))
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 10)
            }
            
           
        }
        .padding(20)
            
            
    }
}

