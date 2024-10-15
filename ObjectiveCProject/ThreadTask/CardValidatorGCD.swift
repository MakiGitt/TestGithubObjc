//
//  CardValidatorGCD.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 10.08.2024.
//

import Foundation

class CardValidatorGCD {
    let counter = CardValidationCounter()

    func validateCards(_ cards: [BankCard]) {
        let group = DispatchGroup()
        for card in cards {
            group.enter()
            DispatchQueue.global(qos: .userInitiated).async {
                if self.validateCardNumber(card) {
                    self.counter.increment()
                }
                group.leave()
            }
        }
        group.notify(queue: .main) {
            print("Total validated cards: \(self.counter.value)")
        }
    }

    func validateCardNumber(_ card: BankCard) -> Bool {
        let regex = "^[0-9]{16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: card.number)
    }
}

class CardValidatorMutex {
    private var validatedCount = 0
    private let mutex = NSLock()

    func validateCards(_ cards: [BankCard]) {
        let group = DispatchGroup()

        for card in cards {
            group.enter()
            DispatchQueue.global().async {
                let isValid = self.validateCardNumber(card)
                if isValid {
                    self.incrementValidatedCount()
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            print("Total validated cards: \(self.validatedCount)")
        }
    }

    func validateCardNumber(_ card: BankCard) -> Bool {
        let regex = "^[0-9]{16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: card.number)
    }

    private func incrementValidatedCount() {
        mutex.lock()
        validatedCount += 1
        mutex.unlock()
    }
}

class CardValidatorSemaphore {
    private var validatedCount = 0
    private let semaphore = DispatchSemaphore(value: 1)

    func validateCards(_ cards: [BankCard]) {
        let group = DispatchGroup()
        let semaphoreLoop = DispatchSemaphore(value: cards.count)
        for card in cards {
            semaphoreLoop.wait()
            DispatchQueue.global().async {
                let isValid = self.validateCardNumber(card)
                if isValid {
                    self.incrementValidatedCount()
                }
                semaphoreLoop.signal()
            }
        }
        semaphoreLoop.wait()
        print("Counter \(validatedCount)")
//        group.notify(queue: .main) {
//            print("Total validated cards: \(self.validatedCount)")
//        }
    }

    func validateCardNumber(_ card: BankCard) -> Bool {
        let regex = "^[0-9]{16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: card.number)
    }

    private func incrementValidatedCount() {
        semaphore.wait()
        validatedCount += 1
        semaphore.signal()
    }
}
