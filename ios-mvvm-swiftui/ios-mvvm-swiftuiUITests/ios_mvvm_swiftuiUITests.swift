//
//  ios_mvvm_swiftuiUITests.swift
//  ios-mvvm-swiftuiUITests
//
//  Created by Antonio Moreno on 27/2/24.
//

import XCTest
import SwiftUI
import SnapshotTesting
@testable import ios_mvvm_swiftui

final class ios_mvvm_swiftuiUITests: XCTestCase {

    func testContactForm() throws {
        isRecording = false
        let contactFormView = ContactFormView()
        let hostingController = UIHostingController(rootView: contactFormView)
        let view: UIView = hostingController.view

        assertSnapshot(matching: view, as: .image(size: CGSize(width: 375, height: 667)))
    }
}
