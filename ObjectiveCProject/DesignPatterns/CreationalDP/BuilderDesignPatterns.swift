//
//  BuilderDesignPatterns.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 29.07.2024.
//

import Foundation

struct CardData {
    let cardNumber: String
    let expirationDate: String
}

struct CardDataBuilder {
    private var cardNumber: String = ""
    private var expirationDate: String = ""

    @discardableResult
    mutating func withCardNumber(_ cardNumber: String) -> CardDataBuilder {
        self.cardNumber = cardNumber
        return self
    }
    @discardableResult
    mutating func withExpirationDate(_ expirationDate: String) -> CardDataBuilder {
        self.expirationDate = expirationDate
        return self
    }

    func build() -> CardData? {
        return CardData(cardNumber: cardNumber, expirationDate: expirationDate)
    }
}
