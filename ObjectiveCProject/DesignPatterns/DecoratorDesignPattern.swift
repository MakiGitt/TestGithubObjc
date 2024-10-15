//
//  DecoratorDesignPattern.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import Foundation

// Component Protocol
protocol CardValidatorProtocol {
    func validate(cardNumber: String) -> Bool
}

// Concrete Component
class BasicCardValidator: CardValidatorProtocol {
    func validate(cardNumber: String) -> Bool {
        return CardValidatorBase1.validateLength(cardNumber)
    }
}

// Concrete Decorator for Prefix Validation
class PrefixValidatorDecorator: CardValidatorProtocol {
    let wraper: CardValidatorProtocol

    init(wraper: CardValidatorProtocol) {
        self.wraper = wraper
    }

    func validate(cardNumber: String) -> Bool {
        return validate(cardNumber: cardNumber) && validatePrefix(cardNumber)
    }

    private func validatePrefix(_ cardNumber: String) -> Bool {
        let prefixes = ["4", "51", "55"] // Visa and MasterCard prefixes
        for prefix in prefixes {
            if cardNumber.hasPrefix(prefix) {
                return true
            }
        }
        return false
    }
}

// Base class for Luhn validation logic
class CardValidatorBase1 {
    static func validateLength(_ cardNumber: String) -> Bool {
        return cardNumber.count >= 13 && cardNumber.count <= 16
    }
}
