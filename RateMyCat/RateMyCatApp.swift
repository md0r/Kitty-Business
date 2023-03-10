//
//  RateMyCatApp.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 09.01.2023.
//

import SwiftUI

@main
struct RateMyCatApp: App {
    var body: some Scene {
        
        let loginUserService = LoginUserService()
        let loginViewModel = LoginViewModel(loginUserService: loginUserService)
        
        WindowGroup {
            LoginView(loginViewModel: loginViewModel)
        }
        
    }
}
