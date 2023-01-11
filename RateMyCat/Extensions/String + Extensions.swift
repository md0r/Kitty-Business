//
//  String + Extensions.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation

extension String {
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
}


