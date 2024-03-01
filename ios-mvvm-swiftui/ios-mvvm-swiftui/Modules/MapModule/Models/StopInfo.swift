//
//  StopInfo.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 1/3/24.
//

import Foundation

struct StopInfo: Codable, Identifiable {
    var id: Int
    let point: Point?
    let price: Double
    let address: String
    let paid: Bool
    let stopTime: String
    let userName: String
    
    enum CodingKeys: String, CodingKey {
        case id = "tripId"
        case point, price, address, paid, stopTime, userName
    }
}
