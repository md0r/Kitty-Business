//
//  CatBreedsListView.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import SwiftUI

struct CatBreedsListView: View {
    
    @StateObject private var catBreedsListViewModel : CatBreedsListViewModel
    
    init(catBreedsListViewModel: CatBreedsListViewModel) {
        _catBreedsListViewModel = StateObject(wrappedValue: catBreedsListViewModel)
    }
    
    var body: some View {
      
       let filteredBreeds = self.catBreedsListViewModel.searchTerm.isEmpty ? self.catBreedsListViewModel.catBreedsViewModels : self.catBreedsListViewModel.catBreedsViewModels.filter { $0.country.starts(with: self.catBreedsListViewModel.searchTerm.lowercased() ) }
        
        return NavigationView {
             
            GeometryReader { geometry in
                
                ScrollView(.vertical) {
                    if (catBreedsListViewModel.errorRetrievingData) {
                        Text(ClientSideErrorMessages.serverError.rawValue)
                            .frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                    } else {
                        
                        if(catBreedsListViewModel.catBreedsViewModels.count > 0) {
                            
                            SearchBarView(searchTerm: $catBreedsListViewModel.searchTerm)
                            LazyVStack {
                                ForEach(filteredBreeds, id: \.id) { catBreedVM in
                                 
                                    NavigationLink {
                                        CatBreedDetailView(catBreed: catBreedVM)
                                    } label: {
                                        CatBreedCardView(catBreed: catBreedVM)
                                    }
                                    
                                }
                            }
                            
                        } else {
                            VStack{
                                ProgressView()
                            }
                            .frame(width: geometry.size.width)
                            .frame(minHeight: geometry.size.height)
                        }
                        
                    }
                }
             
            }
            
        .navigationBarTitle("Kitty Business")
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(Color.teal, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        }
        
        .onAppear {
            catBreedsListViewModel.retrieveData()
        }
        
    }
}

