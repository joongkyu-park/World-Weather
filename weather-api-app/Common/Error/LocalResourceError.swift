//
//  LocalResourceError.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import Foundation

enum LocalResourceError: Error {
    
    case notFindingResource
    
    var description: String {
        switch self {
        case .notFindingResource:
            return "Not Finding Resource."
        }
    }
}
