//
//  CatBreedCardView.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 11.01.2023.
//

import SwiftUI


struct CatBreedCardView: View {
    
    let catBreed: CatBreedViewModel
   
    var body: some View {
        
        HStack(alignment: .center) {
            
            AsyncImage(url: URL(string: catBreed.imageUrl)) { image in
                 image.resizable()
                      .scaledToFill()
                      .frame(width: 80, height: 80)
                      .clipShape(Rectangle())


             } placeholder: {
                 Rectangle().fill(Color.teal)
                     .frame(width: 80, height: 80)
             }
             .frame(width: 80, height: 80)
             .padding(.leading, 20)

            VStack(alignment: .leading, spacing: 5) {
                 Text(catBreed.name)
                     .lineLimit(1)
                     .font(.headline)
                     .foregroundColor(Color.teal)
                     .frame(maxWidth: .infinity, alignment: .leading)
                 Text(catBreed.description)
                    .lineLimit(3)
                    .foregroundColor(Color(uiColor: UIColor.darkGray))
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
             }
             .padding(.trailing, 20)
             .padding(.leading, 10)

        }
         .padding(.vertical, 10)
        
    }
    
}
