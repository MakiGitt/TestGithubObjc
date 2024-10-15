//
//  ChainofResponsibilityDesignPattern.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import Foundation

protocol CardValidationHandler {
    var nextHandler: CardValidationHandler? { get set }
    func handle(cardNumber: String) -> Bool
}

class LengthValidationHandler: CardValidationHandler {
    var nextHandler: CardValidationHandler?

    func handle(cardNumber: String) -> Bool {
        if cardNumber.count == 16 {
            return nextHandler?.handle(cardNumber: cardNumber) ?? true
        } else {
            return false
        }
    }
}

class RegexValidationHandler: CardValidationHandler {
    var nextHandler: CardValidationHandler?

    func handle(cardNumber: String) -> Bool {
        let regex = "^[0-9]{16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        if predicate.evaluate(with: cardNumber) {
            return nextHandler?.handle(cardNumber: cardNumber) ?? true
        } else {
            return false
        }
    }
}
