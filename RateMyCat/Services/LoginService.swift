//
//  LoginProtocol.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidServerResponse
    case badUrl
}

protocol LoginService  {
    func loginResource(args: Data) async throws -> ServerResponse?
}
