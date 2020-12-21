//
//  TermsModal.swift
//  Sudoku Helper
//
//  Created by Axel Lefaux on 05/12/2020.
//

import SwiftUI

struct TermsModal: View {
    @Environment(\.presentationMode) var presentation
    @State var title: String
    @Binding var terms: [Term]
    @State var oldTerms: [Term] = []
    
    var body: some View {
        VStack {
            Text(self.title)
                .font(.title)
            LazyVGrid(
                columns: Array(repeating: .init(.flexible()), count: 3),
                alignment: .center,
                spacing: 8,
                pinnedViews: []
            ) {
                Section {
                    ForEach(0...terms.count - 1, id: \.self) { index in
                        TermItem(isSelected: $terms[index].isSelected, number: terms[index].number)
                    }
                }
            }
            Spacer()
            HStack {
                Spacer()
                Button("Annuler") {
                    self.terms = oldTerms
                    self.presentation.wrappedValue.dismiss()
                }
                Button("Valider") {
                    self.presentation.wrappedValue.dismiss()
                }
            }
        }.padding(16)
        .onAppear {
            self.oldTerms = terms.map { $0.copy() as! Term }
        }
    }
}

struct TermItem: View {
    @Binding var isSelected: Bool
    var number: Int
    
    var body: some View {
        Button(action: {
            isSelected.toggle()
        }) {
            if isSelected {
                Rectangle()
                    .foregroundColor(.green)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Text("\(number)")
                    )
            } else {
                Rectangle()
                    .foregroundColor(.white)
                    .aspectRatio(1, contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                    .overlay(
                        Text("\(number)")
                    )
            }
        }
    }
}

struct TermsModal_Previews: PreviewProvider {
    static var previews: some View {
        TermsModal(title: "Popup title", terms: .constant(HomeViewModel().notUsedTerms))
    }
}
