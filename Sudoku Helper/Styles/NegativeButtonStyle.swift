//
//  NegativeButtonStyle.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 22/12/2020.
//

import SwiftUI

struct NegativeButtonStyle: ButtonStyle {
    var color: Color = .green
    
    public func makeBody(configuration: NegativeButtonStyle.Configuration) -> some View {
        
        configuration.label
            .foregroundColor(.red)
    }
}
