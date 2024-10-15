//
//  CardValidator.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import Foundation

struct CardValidatorBase {

    // Function to validate card number length
    static func isValidCardLength(_ cardNumber: String) -> Bool {
        let length = cardNumber.count
        return (length >= 13 && length <= 16) || length == 0
    }

    // Function to validate card number prefix for different card types
    static func isValidCardPrefix(_ cardNumber: String) -> Bool {
        guard let prefix = Int(cardNumber.prefix(1)) else { return false }
        let validPrefixes = [3, 4, 5, 6]
        return validPrefixes.contains(prefix)
    }

    // Comprehensive card validation function
    static func validateCard(_ cardNumber: String) -> Bool {
        return isValidCardLength(cardNumber) && isValidCardPrefix(cardNumber)
    }
}
