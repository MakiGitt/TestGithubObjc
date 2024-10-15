//
//  FactoryDesignPattern.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import Foundation

// Factory Method Pattern
protocol CardValidator {
    func validate(cardNumber: String) -> Bool
}

protocol ValidatorFactory {
    func createValidator() -> CardValidator
}

class DefaultValidator: CardValidator {
    func validate(cardNumber: String) -> Bool {
        return CardValidatorBase.validateCard(cardNumber)
    }
}

class VisaValidator: CardValidator {
    func validate(cardNumber: String) -> Bool {
        return CardValidatorBase.validateCard(cardNumber)
    }
}

class CardValidatorFactory {
    static func createValidator(type: CardType) -> CardValidator {
        switch type {
        case .visa:
            return VisaValidator()
        case .unknown, .mastercard:
            return DefaultValidator()
        }
    }
}

class CardService {
    func validateCard(cardNumber: String) -> Bool {
        // Use the CardValidatorFactory to get the appropriate validator
        let validator = CardValidatorFactory.createValidator(type: .mastercard)
        return validator.validate(cardNumber: cardNumber)
    }
}
