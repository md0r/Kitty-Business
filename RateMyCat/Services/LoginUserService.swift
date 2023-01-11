//
//  LoginUserService.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation

class LoginUserService: LoginService {
   
    func loginResource(args: Data) async throws -> ServerResponse? {
      
        let serverResponse =  await FakeBackend().login(jsonData: args)
       
        guard let response = serverResponse else {
            throw NetworkError.invalidServerResponse
        }
        
        return response
        
    }
    
}
