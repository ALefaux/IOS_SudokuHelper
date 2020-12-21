//
//  HomeViewModel.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 13/12/2020.
//

import Foundation

final class HomeViewModel: ObservableObject {
    @Published var notUsedTerms: [Term] = [
        Term(number: 1),
        Term(number: 2),
        Term(number: 3),
        Term(number: 4),
        Term(number: 5),
        Term(number: 6),
        Term(number: 7),
        Term(number: 8),
        Term(number: 9)
    ]
    @Published var notUsedTermsString: String = ""
    @Published var mustUsedTerms: [Term] = [
        Term(number: 1),
        Term(number: 2),
        Term(number: 3),
        Term(number: 4),
        Term(number: 5),
        Term(number: 6),
        Term(number: 7),
        Term(number: 8),
        Term(number: 9)
    ]
    @Published var mustUsedTermsString = ""
    @Published private(set) var results: [[Int]] = []
    
    func showNotUsedTerms() {
        let tempPossibleTerms = notUsedTerms.filter { $0.isSelected }
        
        if tempPossibleTerms.count > 0 {
            notUsedTermsString = "[\(tempPossibleTerms.map { "\($0.number)" }.joined(separator: ", "))]"
        } else {
            notUsedTermsString = ""
        }
    }
    
    func showMustUsedTerms() {
        let tempMustUsedTerms = mustUsedTerms.filter { $0.isSelected }
        
        if tempMustUsedTerms.count > 0 {
            mustUsedTermsString = "[\(tempMustUsedTerms.map{ "\($0.number)" }.joined(separator: ", "))]"
        } else {
            mustUsedTermsString = ""
        }
    }
    
    func findResults(sumToFind: Int, numberOfTerms: Int) {
        let mustUsedTerms: [Int] = self.mustUsedTerms.filter { $0.isSelected }.map { $0.number }
        var possibleTerms: [Int] = self.notUsedTerms.filter { !$0.isSelected }.map { $0.number }
        possibleTerms.removeAll(mustUsedTerms)
        
        var results: [[Int]] = []
        let resultsFind = findResults(
            sumToFind: sumToFind - mustUsedTerms.sum(),
            numberOfTerms: numberOfTerms - mustUsedTerms.count,
            possibleTerms: possibleTerms.map { [$0] }
        )
        for resultFind in resultsFind {
            var result: [Int] = []
            result.addAll(mustUsedTerms)
            result.addAll(resultFind)
            results.append(result)
        }
        
        self.results = results
    }
    
    private func findResults(sumToFind: Int, numberOfTerms: Int, possibleTerms: [[Int]]) -> [[Int]] {
        var possibleTerms: [[Int]] = possibleTerms
        var termsGoal: [[Int]] = [[Int]]()
        
        if numberOfTerms > 2 {
            let subNumberOfTerms = numberOfTerms - 1
            
            while (possibleTerms.count > 1) {
                if let firstSumFound = possibleTerms.first {
                    possibleTerms.remove(at: 0)
                    let subGoal = sumToFind - firstSumFound.sum()
                    let results = findResults(sumToFind: subGoal, numberOfTerms: subNumberOfTerms, possibleTerms: possibleTerms)
                    for result in results {
                        var goal: [Int] = []
                        goal.addAll(firstSumFound)
                        goal.addAll(result)
                        termsGoal.append(goal)
                    }
                }
            }
        } else if numberOfTerms > 1 {
            while (possibleTerms.count > 1) {
                if var firstNumber = possibleTerms.first {
                    possibleTerms.remove(at: 0)
                    
                    for term in possibleTerms {
                        if (firstNumber.sum() + term.sum() == sumToFind) {
                            firstNumber.addAll(term)
                            termsGoal.append(firstNumber)
                        }
                    }
                }
            }
        } else {
            termsGoal.append([sumToFind])
        }
        
        return termsGoal
    }
}
