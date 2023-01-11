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
    
    func validateInputAndTryToPerformLogin() async {
        
        var errors = false
        
        if username == "" || password == "" {
            errors = true
        }
        
        //some basic validation -> we allow only alphanumerical characters for this example
        if !username.isAlphanumeric || !password.isAlphanumeric {
            errors = true
        }
        
        if(errors) {
            validationMessage = ClientSideErrorMessages.checkCredentials.rawValue
        } else {
            await validateLogin()
        }
        
    }
    
    
    func validateLogin() async {
        
        do {
          
            let trimmedUsername = username.trimmingCharacters(in: .whitespacesAndNewlines)
            let trimmedPassword = password.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let userCredentials = ["username" : trimmedUsername,  "password" : trimmedPassword ]
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
