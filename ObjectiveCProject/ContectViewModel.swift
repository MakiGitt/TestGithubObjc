//
//  ContectViewModel.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 06.08.2024.
//

import SwiftUI
import Combine

class ContectViewModel: ObservableObject {
    @Published var result: Int = 0
    @Published var converterData: String = ""
    private let service = ConverterDataService()

    func maxValueObjC(num1: String, num2: String) {
        guard let num1 = Int32(num1), let num2 = Int32(num2) else {
            result = -1
            return
        }
        result = Int(Calculation().maxNumbers(num1, number2: num2))
    }

    func showrResult() {
        converterData = service.convert(number: result)
    }
}
