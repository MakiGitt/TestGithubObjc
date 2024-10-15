//
//  FacadeDesignPattern.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import Foundation

class CardValidatorFacade {
    private let visaValidator: CardValidationStrategy
    private let masterCardValidator: CardValidationStrategy

    init() {
        self.visaValidator = VisaValidationStrategy()
        self.masterCardValidator = MasterCardValidationStrategy()
    }

    func isValid(cardNumber: String) -> Bool {
        let cardType = determineCardType(cardNumber: cardNumber)

        switch cardType {
        case .visa:
            return visaValidator.validate(cardNumber: cardNumber)
        case .mastercard:
            return masterCardValidator.validate(cardNumber: cardNumber)
        default:
            return false
        }
    }

    private func determineCardType(cardNumber: String) -> CardType {
        let prefix = cardNumber.prefix(2)

           switch prefix {
           case "40", "41", "42", "43", "44", "45", "46", "47", "48", "49":
               return .visa
           case "51", "52", "53", "54", "55":
               return .mastercard
           default:
               return .unknown
           }
    }
}

enum CardType {
    case visa
    case mastercard
    case unknown
}
