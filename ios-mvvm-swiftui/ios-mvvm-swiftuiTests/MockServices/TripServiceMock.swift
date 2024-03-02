//
//  TripServiceMock.swift
//  ios-mvvm-swiftuiTests
//
//  Created by Antonio Moreno on 2/3/24.
//

import Foundation
import XCTest

class TripServiceMock: TripServiceDelegate {

    enum Result {
        case fetchTripSuccess([Trip])
        case fetchStopSuccess(StopInfo)
        case failure(Error)
    }

    var expectedResult: Result?

    func fetchTrip() async throws -> [Trip] {
        switch expectedResult {
        case .fetchTripSuccess(let trips):
            return trips
        case .failure(let error):
            throw error
        case nil:
            XCTFail("Unexpected error")
            return []
        default:
            return []
        }
    }

    func fetchStop() async throws -> StopInfo? {
        switch expectedResult {
        case .fetchStopSuccess(let stopInfo):
            return stopInfo
        case .failure(let error):
            throw error
        case nil:
            XCTFail("Unexpected error")
            return nil
        default:
            return nil
        }
    }
}
