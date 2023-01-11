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
        VStack {
            Text(catBreed.name)
        }
    }
}

