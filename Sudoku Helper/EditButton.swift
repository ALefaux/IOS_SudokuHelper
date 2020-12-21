//
//  EditButton.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 15/12/2020.
//

import SwiftUI

struct EditButton: View {
    private var title: String
    private var placeholder: String
    private var value: String
    private var action: () -> Void
    
    init(title: String, value: String, placeholder: String = "", action: @escaping () -> Void) {
        self.title = title
        self.value = value
        self.placeholder = placeholder
        self.action = action
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(self.title)
                Text(self.value.isEmpty ? self.placeholder : self.value)
                    .font(.caption)
            }
            Spacer()
            Button(action: self.action, label: {
                Image(systemName: "pencil")
            })
            
        }.padding(.top)
        .padding(.bottom)
    }
}
