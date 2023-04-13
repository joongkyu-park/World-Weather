//
//  NetworkError.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

enum NetworkError: Error {
    
    case requestError(Int)
    case serverError(Int)
    case networkFailError(Int)
    case invalidURLComponents(String)
    case invalidURLString
    case invalidServerResponse
    case nonStatusCode
    
    var description: String {
        switch self {
        case .requestError(let statusCode):
            return "Request error(statusCode: \(statusCode)."
        case .serverError(let statusCode):
            return "Server error(statusCode: \(statusCode)."
        case .networkFailError(let statusCode):
            return "Network fail error(statusCode: \(statusCode)."
        case .invalidURLComponents(let path):
            return "Invalid URL Components(path: \(path)."
        case .invalidURLString:
            return "Invalid URL String."
        case .invalidServerResponse:
            return "Invalid server response."
        case .nonStatusCode:
            return "Non status code."
        }
    }
    
}
