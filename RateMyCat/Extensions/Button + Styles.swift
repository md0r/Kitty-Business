//
//  Button + Styles.swift
//  RateMyCat
//
//  Created by Mihai Dorhan on 10.01.2023.
//

import Foundation
import SwiftUI

struct LargeRoundedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
            .font(.title2)
            .padding()
            .foregroundColor(.white)
            .background(Color.teal)
            .cornerRadius(8)
    }
}
