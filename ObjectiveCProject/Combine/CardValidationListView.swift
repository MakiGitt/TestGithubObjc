//
//  CardValidationListView.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 27.08.2024.
//

import SwiftUI
import Foundation

struct CardValidationListView: View {
    @StateObject private var viewModel = CardValidationViewModel()
    @State private var cardNumber: String = ""

    var body: some View {
        VStack {
            TextField("Введіть номер картки", text: $cardNumber)
                .padding()
               // .keyboardType(.numberPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .padding()

            Button(action: {
                viewModel.addCard(number: cardNumber)
                viewModel.addCardUsingSubject(number: cardNumber)
                cardNumber = ""
            }) {
                Text("Додати картку")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()

            List(viewModel.cards) { card in
                HStack {
                    Text(card.number)
                        .font(.headline)

                    Spacer()

                    Text(card.isValid ? "Валідна" : "Невалідна")
                        .foregroundColor(card.isValid ? .green : .red)
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
    }
}
