//
//  ContentView.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 05/12/2020.
//

import SwiftUI

struct HomeView: View {
    @State private var sumToFind: String = ""
    @State private var numberOfTerms: String = ""
    
    var body: some View {
        VStack {
            TextField("Somme à trouver", text: $sumToFind)
            TextField("Nombre de termes", text: $numberOfTerms)
            Text("Hello, world!")
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
