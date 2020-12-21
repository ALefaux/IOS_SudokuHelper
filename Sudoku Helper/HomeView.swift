//
//  ContentView.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 05/12/2020.
//

import SwiftUI
import Combine

struct HomeView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    @State private var sumToFind: String = ""
    @State private var numberOfTerms: String = ""
    @State private var showNotUsedTermsModal: Bool = false
    @State private var showMustUsedTermsModal: Bool = false
    @State private var showingAlert: Bool = false
    @State private var errorMessage: String = ""
    
    private var notUsedTermsTitle: String = "Termes à ne pas utiliser"
    private var mustUsedTermsTitle: String = "Termes obligatoires"
    
    var body: some View {
        VStack {
            Text("Sudoku Helper")
                .font(.title)
            TitleTextField(title: "Somme à trouver", text: $sumToFind)
            TitleTextField(title: "Nombre de termes", text: $numberOfTerms)
            Text("Termes")
                .font(.title2)
            EditButton(title: notUsedTermsTitle, value: viewModel.notUsedTermsString, placeholder: "Termes tous possibles") {
                hideKeyboard()
                self.showNotUsedTermsModal = true
            }.sheet(isPresented: $showNotUsedTermsModal, onDismiss: {
                viewModel.showNotUsedTerms()
            }) {
                TermsModal(title: notUsedTermsTitle, terms: $viewModel.notUsedTerms)
            }
            EditButton(title: mustUsedTermsTitle, value: viewModel.mustUsedTermsString, placeholder: "Aucun termes obligatoires") {
                hideKeyboard()
                self.showMustUsedTermsModal = true
            }.sheet(isPresented: $showMustUsedTermsModal, onDismiss: {
                viewModel.showMustUsedTerms()
            }) {
                TermsModal(title: mustUsedTermsTitle, terms: $viewModel.mustUsedTerms)
            }
            if(!viewModel.results.isEmpty) {
                Text("Résultats")
                    .font(.title2)
            }
            List(viewModel.results, id: \.self) { result in
                let resultString = (result as [Int]).map { "\($0)" }.joined(separator: ";")
                Text("[\(resultString)]")
            }
            Spacer()
            Button(action: {
                hideKeyboard()
                if let sumToFind = Int(self.sumToFind) {
                    if let numberOfTerms = Int(self.numberOfTerms) {
                        self.viewModel.findResults(
                            sumToFind: sumToFind,
                            numberOfTerms: numberOfTerms
                        )
                    } else {
                        self.errorMessage = "Veuillez renseigner le nombre de termes à utiliser"
                        self.showingAlert = true
                    }
                } else {
                    self.errorMessage = "Veuillez renseigner la somme à trouver"
                    self.showingAlert = true
                }
            }) {
                Text("Trouver les combinaisons")
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text("Données manquantes"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
            }
            
        }.padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
