//
//  ActorMainClass.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 04.09.2024.
//

import Foundation

class ActorMainClass {
    let cards = ["1234567812345678", "8765432187654321", "1111222233334444", "4123456743456778"]
    let validator = CardValidatorActor()

    func startValidation() {
        Task {
            await validator.validate(cards: cards)
            let count = await validator.counter
            print("Validated cards count: \(count)")
        }
    }
}
