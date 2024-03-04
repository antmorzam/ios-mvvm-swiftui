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
            return "Sorry, it was imposible retrieve some trips. \n Try again later."
        }
    }
}
