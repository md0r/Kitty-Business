//
//  LoginView.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import SwiftUI

struct LoginView: View {
            
    @StateObject private var loginViewModel: LoginViewModel
       
    init(loginViewModel: LoginViewModel) {
        _loginViewModel = StateObject(wrappedValue: loginViewModel)
    }
    
    var body: some View {
        
            VStack(alignment: .center, spacing: 20) {
               
                Text("Kitty Business")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(Color.teal)
                
                TextField("Enter username", text: $loginViewModel.username)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                TextField("Enter password", text: $loginViewModel.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                Button {
                    loginViewModel.validateInputAndTryToPerformLogin()
                } label: {
                    Text("Login")
                }
                .buttonStyle(LargeRoundedButtonStyle())
                
                Text(loginViewModel.validationMessage)
                    .font(.system(size: 18, weight: .none, design: .none))
                    .foregroundColor(Color.red)
                    .frame(height: 15, alignment: .center)
            }
            .padding(40)
        
            .fullScreenCover(isPresented: $loginViewModel.navigateToNextView) {
        
                let retrieveDataService = RetrieveCatBreedsService()
                let catBreedsListViewModel = CatBreedsListViewModel(retrieveDataService: retrieveDataService)
                CatBreedsListView(catBreedsListViewModel: catBreedsListViewModel)
                
            }
            
            
    }
}


