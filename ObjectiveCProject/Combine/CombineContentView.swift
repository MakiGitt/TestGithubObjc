//
//  CombineContentView.swift
//  ObjectiveCProject
//
//  Created by Anzhelika Makar on 27.08.2024.
//

import SwiftUI

struct CombineContentView: View {
    var body: some View {
        VStack(spacing: 16) {
            CardCombineValidationView()
            CardValidationListView()
        }
    }
}

#Preview {
    CombineContentView()
}
