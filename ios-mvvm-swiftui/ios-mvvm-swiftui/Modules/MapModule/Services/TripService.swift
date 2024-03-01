//
//  TripService.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 27/2/24.
//

import Foundation

protocol TripServiceDelegate: AnyObject {
    func fetchTrip() async throws -> [Trip]
    func fetchStop() async throws -> StopInfo
}

class TripService: TripServiceDelegate {
    
    func fetchTrip() async throws -> [Trip] {
        guard let url = URL(string: Constants.API.tripsEndpoint) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let tripList = try JSONDecoder().decode([Trip].self, from: data)

        return tripList
    }
    
    func fetchStop() async throws -> StopInfo {
        guard let url = URL(string: Constants.API.stopEndpoint) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let stopInfo = try JSONDecoder().decode(StopInfo.self, from: data)

        return stopInfo
    }
}
