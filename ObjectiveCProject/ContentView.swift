//
//  ContentView.swift
//  ObjectiveC_Project
//
//  Created by Anzhelika Makar on 28.05.2024.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var maxValue: Int = 0
    @State private var num1: String = ""
    @State private var num2: String = ""
    @State private var showMessage: Bool = false
    @StateObject private var viewModel = ContectViewModel()

    let service = ThreadMainClass()
    let actorService = ActorMainClass()

    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Input two numbers").bold().foregroundStyle(.blue)
            HStack(alignment: .center) {
                TextField("Number one", text: $num1).frame(width: 100).onChange(of: num1) {
                    showMessage = false
                }
                TextField("Number two", text: $num2).frame(width: 100).onChange(of: num2) {
                    showMessage = false
                }
            }
            Button(
                action: {
                    showMessage = true
                    viewModel.maxValueObjC(num1: num1, num2: num2)
                    viewModel.showrResult()
                    self.maxValue = viewModel.result
                    print("Converter result \(viewModel.converterData)")
                },
                label: {
                    Text("Сalculate").bold()
                }
            )
            .padding()
            .backgroundStyle(.yellow)
            .onAppear {
               // service.startValidation()
                actorService.startValidation()

            }
            if showMessage, maxValue != -1 {
                Text("Max number is: \(self.maxValue)")
            } else if maxValue == -1 {
                Text("Incorect numbers type").foregroundStyle(.red)
            }
        }
    }
}
