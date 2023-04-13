//
//  DataError.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import Foundation

enum DataError: Error {
    
    case decodeError(toType: Decodable.Type)
    case nonData
    
    var description: String {
        switch self {
        case .decodeError(let type):
            return "Decoding error(type: \(type)."
        case .nonData:
            return "Non data."
        }
    }
    
}
