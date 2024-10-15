//
//  CardValidationCounter.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 10.08.2024.
//

import Dispatch
class CardValidationCounter {
    private var count: Int = 0
    private let queue = DispatchQueue(label: "cardValidationCounterQueue")

    func increment() {
        queue.async {
            self.count += 1
        }
    }

    var value: Int {
        queue.sync {
            return count
        }
    }
}
