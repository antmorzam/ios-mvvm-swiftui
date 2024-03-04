//
//  Errors.swift
//  ios-mvvm-swiftui
//
//  Created by Antonio Moreno on 28/2/24.
//

import Foundation

enum UserError: Error {
    case failedFecthingData
    
    var description: String {
        switch self {
        case .failedFecthingData:
            return NSLocalizedString("error_trips", comment: "error downloading trips")
        }
    }
}
