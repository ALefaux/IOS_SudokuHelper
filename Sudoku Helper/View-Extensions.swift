//
//  View-Extensions.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 16/12/2020.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
