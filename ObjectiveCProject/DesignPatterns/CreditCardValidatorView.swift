//
//  CreditCardValidatorView.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import SwiftUI

struct CreditCardValidatorView: View {
    @State private var cardNumber = ""
    @State private var expirationMonth = ""
    @State private var expirationYear = ""
    @State private var validationMessage = ""
    @State private var expirationDate = ""
    @State private var isValidBankCard = true
    @State private var isValidDate = true

    let cardService = CardService()
    let basicValidator = BasicCardValidator()
    var builder = CardDataBuilder()
    let lengthHandler = LengthValidationHandler()
    let regexHandler = RegexValidationHandler()
    let service = ThreadMainClass()

    var body: some View {
        VStack {
            HStack {
                Text("Номер кредитної картки")
                Spacer()
            }.padding(.leading, 16)
                .padding(.bottom, 8)
            TextField("Введіть номер", text: $cardNumber)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                .padding()
                // .keyboardType(.numberPad)
                .onChange(of: cardNumber) { newValue in
                    isValidBankCard = cardService.validateCard(cardNumber: newValue)
                    let validator = CardValidatorPattern(strategy: LengthValidationStrategy())

                    validator.setStrategy(RegexValidationStrategy())

                    // Chain of Responsibility Pattern
                    if lengthHandler.handle(cardNumber: cardNumber) {
                        print("Card number is valid.")
                    } else {
                        print("Card number is invalid.")
                    }
                    if isValidDate == true {

                    }
                    // Facade
                    let facade = CardValidatorFacade()
                    _ = facade.isValid(cardNumber: cardNumber)
                }
            if !isValidBankCard {
                Text("Номер банківської картки не коректний")
                    .foregroundColor(.red)
                    .padding()
            }
            HStack {
                TextField("Місяць", text: $expirationMonth)
                   // .keyboardType(.numberPad)
                    .frame(width: 60)
                Text("/")
                TextField("Рік", text: $expirationYear)
                   // .keyboardType(.numberPad)
                    .frame(width: 50)
                Spacer()
            } .padding()
                .overlay(RoundedRectangle(cornerRadius: 10.0).strokeBorder(Color.black, style: StrokeStyle(lineWidth: 1.0)))
                .padding()
                .frame(alignment: .leading)
                .onChange(of: [expirationMonth, expirationYear]) { _ in
                    validateExpirationDate()
                }
            Text(validationMessage)
                .foregroundColor(Color.red)
            Button {
                    saveCardNumber()
            } label: {
                Text("Зберегти банківську картку")
            }.disabled(!isValidBankCard && !isValidDate)

        }.frame(alignment: .leading)
            .onAppear {
                service.startValidation()
            }
    }

    func saveCardNumber() {
        var builder = CardDataBuilder()
        builder.withCardNumber(cardNumber)
        builder.withExpirationDate(expirationDate)
        print("Bank card info: \(String(describing: builder.build()))")
    }

    func validateExpirationDate() {
        if let month = Int(expirationMonth), let year = Int(expirationYear) {
            let calendar = Calendar.current
            _ = calendar.dateComponents([.year, .month], from: Date())
            let expirationDateComponents = DateComponents(year: year, month: month)
            let expirationDate = calendar.date(from: expirationDateComponents)
            if let expirationDate = expirationDate, expirationDate >= Date() {
                validationMessage = ""
                self.expirationDate = "\(expirationMonth)/\(expirationYear)"
                self.isValidDate = true
            } else {
                self.isValidDate.toggle()
                validationMessage = "Дата закінчення терміну дії недійсні"
            }
        } else {
            self.isValidDate.toggle()
            validationMessage = "Неправильний формат дати"
        }
    }
}
#Preview {
    CreditCardValidatorView()
}
