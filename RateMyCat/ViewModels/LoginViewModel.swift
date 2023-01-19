//
//  LoginViewModel.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation

@MainActor
class LoginViewModel: ObservableObject  {
    
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var validationMessage: String = ""
    @Published var navigateToNextView: Bool = false
    
    private var loginUserService: LoginService
    
    init(loginUserService: LoginService) {
        self.loginUserService = loginUserService
    }
    
    func validateInputAndTryToPerformLogin()  {
        
        if !username.isAlphanumeric || !password.isAlphanumeric {
            validationMessage = ClientSideErrorMessages.checkCredentials.rawValue
        } else {
            Task {
                await validateLogin()
            }
        }
        
    }
    
    
    func validateLogin() async {
        
        do {
          
            let userCredentials = ["username" : username,  "password" : password ]
            let jsonData = try JSONSerialization.data(withJSONObject: userCredentials, options: .prettyPrinted)
            
            let serverResponse = try await loginUserService.loginResource(args: jsonData) 
            
            if let response = serverResponse  {
                validationMessage = (response == .validationError) ? response.rawValue : ""
                if response == .successMessage {
                    navigateToNextView = true
                }
            } else {
                validationMessage = ClientSideErrorMessages.serverError.rawValue
            }
            
        }
        catch {
            validationMessage = ClientSideErrorMessages.serverError.rawValue
        }
        
    }
    
    
    
}
