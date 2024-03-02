//
//  LoadingView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 2/3/24.
//

import Foundation
import SwiftUI

struct LoadingView: View {

    var body: some View {
        ZStack {
            Rectangle()
                .fill(.black)
                .opacity(0.2)
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ProgressView()
            }
            .background {
                RoundedRectangle(cornerRadius: 25)
                    .fill(.white)
                    .frame(width: 50, height: 50)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
