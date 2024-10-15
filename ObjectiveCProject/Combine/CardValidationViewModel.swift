//
//  CardValidationViewModel.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 27.08.2024.
//

import SwiftUI
import Combine

struct ConstBankLength {
    static let minLength = 13
    static let maxLength = 16
}

struct Card: Identifiable {
    let id = UUID()
    var number: String
    var isValid: Bool = false
}

class CardValidationViewModel: ObservableObject {
    @Published var cards: [Card] = []
    @Published var cardsUsingSubject: [Card] = []
    @Published var cardNumber: String = ""
    @Published var isCardNumberValid: Bool = true

    private var cardSubject = PassthroughSubject<String, Never>()

    private var cancellables = Set<AnyCancellable>()
    private var cancellablessSub = Set<AnyCancellable>()

    init() {
        validateCardNumber()
    }

    func addCardUsingSubject(number: String) {
        cardSubject.send(number)
        objectWillChange.send()
    }

       private func setupValidationUsingSubject() {
           cardSubject
               .map { [weak self] number in
                   guard let self = self else { return Card(number: number, isValid: false) }
                   return Card(number: number, isValid: self.validateCard(number))
               }
               .sink { [weak self] newCard in
                   self?.cardsUsingSubject.append(newCard)
               }
               .store(in: &cancellablessSub)
       }

    func addCard(number: String) {
        let newCard = Card(number: number, isValid: validateCard(number))
        cards.append(newCard)
    }

    private func setupValidation() {
        $cards
            .map { cards in
                cards.map { card in
                    Card(number: card.number, isValid: self.validateCard(card.number))
                }
            }
            .assign(to: &$cards)
    }

    private func validateCardNumber() {
        $cardNumber
            .removeDuplicates()
            .map { self.validateCard($0) }
            .assign(to: &$isCardNumberValid)
    }

    private func isValidCardLength(_ cardNumber: String) -> Bool {
        let length = cardNumber.count
        return (length >= ConstBankLength.minLength && length <= ConstBankLength.maxLength) || length == 0
    }

    private func isValidCardPrefix(_ cardNumber: String) -> Bool {
        guard let prefix = Int(cardNumber.prefix(1)) else { return false }
        let validPrefixes = [3, 4, 5, 6]
        return validPrefixes.contains(prefix)
    }

    private func validateCard(_ cardNumber: String) -> Bool {
        guard !cardNumber.isEmpty  else { return true }
        return isValidCardLength(cardNumber) && isValidCardPrefix(cardNumber)
    }
}
