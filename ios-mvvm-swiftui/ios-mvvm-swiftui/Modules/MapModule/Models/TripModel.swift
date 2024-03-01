//
//  TripModel.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import Foundation

struct Trip: Codable, Identifiable, Hashable, Equatable {
    var id: UUID { UUID() }
    let driverName: String
    let status: String
    let route: String
    let startTime: String
    let origin: Location
    let description: String
    let destination: Location
    let stops: [Stop]
    let endTime: String
    var isSelected: Bool?
    
    static func == (lhs: Trip, rhs: Trip) -> Bool {
        lhs.route == rhs.route && lhs.startTime == rhs.startTime
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(route)
    }
    
    mutating func setSelected(_ selected: Bool) {
        isSelected = selected
    }
}
