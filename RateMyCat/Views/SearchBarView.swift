//
//  SearchBarView.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 11.01.2023.
//

import SwiftUI


struct SearchBarView: View {
    
    @Binding var searchTerm: String
    
    var body: some View {
      
        HStack {
                
          Spacer()
          Image(systemName: "magnifyingglass")
          TextField("Search by country", text: self.$searchTerm)
                .foregroundColor(Color.primary)
                .padding(10)
          Spacer()
            
         }.foregroundColor(.secondary)
          .background(Color(.secondarySystemBackground))
          .cornerRadius(10)
          .padding(20)
        
    }
    
}
