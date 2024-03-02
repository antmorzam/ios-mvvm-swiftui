//
//  FormView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 2/3/24.
//

import Foundation
import SwiftUI

struct FormView: View {
    @Binding var isPresented: Bool

    var body: some View {
        ContactFormView()
        .padding()
    }
}

struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView(isPresented: .constant(false))
    }
}
