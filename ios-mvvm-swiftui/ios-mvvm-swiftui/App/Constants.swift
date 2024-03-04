//
//  Constants.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import Foundation
import SwiftUI

struct Constants {
    struct API {
        static let baseURL = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/"
        static let tripsEndpoint = baseURL + "trips.json"
        static let stopEndpoint = baseURL + "stops.json"
    }
}

extension Color {
    static let backgroundColor = Color(red: 242.0 / 255.0, green: 242.0 / 255.0, blue: 247.0 / 255.0)
}
