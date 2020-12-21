//
//  TitleTextField.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 15/12/2020.
//

import SwiftUI

struct TitleTextField: View {
    var title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(text.isEmpty ? " " : title)
                .font(.caption)
            TextField(title, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
        }.padding(.top)
    }
}
