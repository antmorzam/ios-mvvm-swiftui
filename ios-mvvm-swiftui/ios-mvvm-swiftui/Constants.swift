//
//  Constants.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import Foundation

struct Constants {
    struct API {
        static let baseURL = "https://sandbox-giravolta-static.s3.eu-west-1.amazonaws.com/tech-test/"
        static let tripsEndpoint = baseURL + "trips.json"
        static let stopEndpoint = baseURL + "stops.json"
    }
}
