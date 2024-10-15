//
//  ValidationCardUseActors.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 04.09.2024.
//

import Foundation

actor CardValidatorActor {
    private(set) var counter: Int = 0

    private func incrementValidatedCount() {
        counter += 1
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

    private func validateCard(_ cardNumber: String) {
        guard !cardNumber.isEmpty  else { return  }
        if  isValidCardLength(cardNumber) && isValidCardPrefix(cardNumber) {
            counter += 1
        }
    }

    func validate(cards: [String]) async {
        await withTaskGroup(of: Void.self) { group in
            for card in cards {
                group.addTask {
                    await self.validateCard(card)
                }
            }
        }
    }
}
