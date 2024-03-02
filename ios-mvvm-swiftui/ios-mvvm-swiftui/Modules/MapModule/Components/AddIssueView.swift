//
//  AddIssueView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 2/3/24.
//

import Foundation
import SwiftUI

struct AddIssueView: View {
    @Binding var addIssue: Bool
    
    var body: some View {
        Button(action: {
            addIssue = true
        }) {
            Image(systemName: "note.text.badge.plus")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(radius: 5)
        }
        .padding(.trailing, 16)
        .padding(.bottom, 16)
    }
}

struct AddIssueView_Previews: PreviewProvider {
    static var previews: some View {
        AddIssueView(addIssue: .constant(false))
    }
}
