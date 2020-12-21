//
//  Array-Extensions.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 16/12/2020.
//

import Foundation

extension Array where Element == Int {
    func sum() -> Int {
        var result: Int = 0
        
        for term in self {
            result += term
        }
        
        return result
    }
    
    mutating func addAll(_ items: [Int]) {
        for item in items {
            self.append(item)
        }
    }
    
    mutating func removeAll(_ items: [Int]) {
        for item in items {
            if let index = self.firstIndex(of: item) {
                self.remove(at: index)
            }
        }
    }
}

extension Array where Element == [Int] {
    mutating func addAll(_ items: [[Int]]) {
        for item in items {
            self.append(item)
        }
    }
}
