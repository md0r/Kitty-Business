//
//  FakeBackend.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation

enum ServerResponse: String {
    case successMessage =  "You are logged in."
    case validationError = "Incorrect username or password."
    case decodingError = "Server error. Please try later."
}

class FakeBackend {

    //we assume these are the "correct" values for the hardcoded user from a database
    let correctUsername = "1"
    let correctPassword = "1"
    
    //I am returning an OPTIONAL ServerResponse here to fake some error handling later on
    func login(jsonData: Data) async -> ServerResponse? {
  
        do {
            
            let decodedUserCredentials = try JSONSerialization.jsonObject(with: jsonData, options: [])
           
            if let userCredentials = decodedUserCredentials as? [String:String] {
               
                if userCredentials["username"] == correctPassword && userCredentials["password"] == correctPassword {
                    return .successMessage
                } else {
                    return .validationError
                }
                
                
            } else {
                return .decodingError
            }
            
        }
        catch {
            return .decodingError
        }
        
    }
    
    
}
