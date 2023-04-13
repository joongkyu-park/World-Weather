//
//  HTTPMethod.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

struct HTTPMethod: RawRepresentable, Equatable, Hashable {
    
    public static let get = HTTPMethod(rawValue: "GET")
    public let rawValue: String
    public init(rawValue: String) {
        self.rawValue = rawValue
    }
    
}
