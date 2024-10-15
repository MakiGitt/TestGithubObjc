//
//  StrategyDesignPattern.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import Foundation

protocol CardValidationStrategy {
    func validate(cardNumber: String) -> Bool
}

class LengthValidationStrategy: CardValidationStrategy {
    func validate(cardNumber: String) -> Bool {
            return cardNumber.count >= 13 && cardNumber.count <= 16
    }
}

class RegexValidationStrategy: CardValidationStrategy {
    func validate(cardNumber: String) -> Bool {
        // Example regex pattern for a 16-digit card number
        let regex = "^[0-9]{16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: cardNumber)
    }
}

class VisaValidationStrategy: CardValidationStrategy {
    func validate(cardNumber: String) -> Bool {
        // Visa card numbers start with 4 and are 16 digits long
        let regex = "^4[0-9]{15}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: cardNumber)
    }
}

class MasterCardValidationStrategy: CardValidationStrategy {
    func validate(cardNumber: String) -> Bool {
        // MasterCard numbers start with 51-55 or 2221-2720 and are 16 digits long
        let regex = "^(5[1-5][0-9]{14}|2(22[1-9][0-9]{12}|2[3-9][0-9]{13}|[3-6][0-9]{14}|7[01][0-9]{13}|720[0-9]{12}))$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: cardNumber)
    }
}

class CardValidatorPattern {
    private var strategy: CardValidationStrategy

    init(strategy: CardValidationStrategy) {
        self.strategy = strategy
    }

    func setStrategy(_ strategy: CardValidationStrategy) {
        self.strategy = strategy
    }

    func validate(cardNumber: String) -> Bool {
        return true
//        return strategies.allSatisfy { str in
//            str.validate(cardNumber: cardNumber)
//        }
    }
}
