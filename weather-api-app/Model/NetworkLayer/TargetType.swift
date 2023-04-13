//
//  TargetType.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

protocol TargetType {
    
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var task: NetworkTask { get }
    var headers: [String: String]? { get }
    
}
