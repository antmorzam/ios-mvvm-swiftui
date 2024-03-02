//
//  ios_mvvm_swiftuiTests.swift
//  ios-mvvm-swiftuiTests
//
//  Created by Antonio Moreno on 27/2/24.
//

import XCTest
@testable import ios_mvvm_swiftui

final class ios_mvvm_swiftuiTests: XCTestCase {
    
    func testLoadData() async {
        let tripServiceMock = TripServiceMock()
        let viewModel = MainViewModel(tripServiceDelegate: tripServiceMock)
        
        let trip = Trip(driverName: "", status: "", route: "", startTime: "", origin: Location(address: "", point: Point(latitude: 0.0, longitude: 0.0)), description: "", destination: Location(address: "", point: Point(latitude: 0.0, longitude: 0.0)), stops: [], endTime: "")
        
        tripServiceMock.expectedResult = .fetchTripSuccess([trip])
        
        do {
            try await viewModel.loadData()
            XCTAssertFalse(viewModel.tripList.isEmpty)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
    
    func testGetStopInfo() async {
        let tripServiceMock = TripServiceMock()
        let viewModel = MainViewModel(tripServiceDelegate: tripServiceMock)
        
        let stopInfo = StopInfo(id: 0,
                                point: Point(latitude: 0.0, longitude: 0.0),
                                price: 0.0,
                                address: "",
                                paid: true,
                                stopTime: "",
                                userName: "")
        
        tripServiceMock.expectedResult = .fetchStopSuccess(stopInfo)
        
        do {
            try await viewModel.getStopInfo()
            XCTAssertNotNil(viewModel.selectedStop)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }
}
