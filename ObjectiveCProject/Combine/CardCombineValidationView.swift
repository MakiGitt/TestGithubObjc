//
//  CardCombineValidationView.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 27.08.2024.
//

import Foundation
import SwiftUI

struct CardCombineValidationView: View {
    @StateObject private var viewModel = CardValidationViewModel()

    var body: some View {
        VStack {
            TextField("Введіть номер картки", text: $viewModel.cardNumber)
                .padding()
                // .keyboardType(.numberPad)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 2)
                )
                .padding()
            if !viewModel.cardNumber.isEmpty {
                Text(viewModel.isCardNumberValid ? "Валідна картка" : "Не валідна картка")
                    .foregroundColor(viewModel.isCardNumberValid ? .green : .red)
                    .padding()
            }
        }
        .padding()
    }

}
