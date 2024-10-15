//
//  ThreadMainClass.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 10.08.2024.
//

import Foundation

class ThreadMainClass {
    let cards = [BankCard(number: "1234567"), BankCard(number: "8765432187654321"), BankCard(number: "4234567812345678") ]

    func startValidation() {
        let validator = CardValidatorSemaphore()
        validator.validateCards(cards)
    }
}
