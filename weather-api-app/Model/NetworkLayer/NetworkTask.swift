//
//  NetworkTask.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

enum NetworkTask {
    
    case requestPlain
    case requestParameters(parameters: [String: Any], encoding: ParameterEncoding)
    
}
