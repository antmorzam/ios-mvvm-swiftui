//
//  CardView.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import SwiftUI

struct CardView: View {
    var id: String? = UUID().uuidString
    var status: String
    var origin: String
    var destination: String
    
    @Binding var isSelected: Bool
        
    private var borderColor: Color {
        isSelected ? .blue : .white
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Status en la esquina superior izquierda
            Text(status)
                .font(.headline)
                .foregroundColor(.blue)
            
            // Origin y Destination uno al lado del otro, separados por una flecha
            HStack(alignment: .top, spacing: 4) {
                Text(origin)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(2)
                
                Image(systemName: "arrow.right.circle.fill")
                    .foregroundColor(.gray)
                
                Text(destination)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(2)
            }
        }
        .padding()
        .background(.white.opacity(0.7))
        .border(borderColor, width: 2)
        .padding()
    }
}

struct TripInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(status: "En curso", origin: "Origen A", destination: "Destino B", isSelected: .constant(false))
    }
}

