//
//  Term.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 08/12/2020.
//

import Foundation

class Term: Identifiable, NSCopying {
    
    func copy(with zone: NSZone? = nil) -> Any {
        return Term(number: number, isSelected: isSelected)
    }
    
    
    let number: Int
    var isSelected: Bool
    
    init(number: Int, isSelected: Bool = false) {
        self.number = number
        self.isSelected = isSelected
    }
}
