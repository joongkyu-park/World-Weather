//
//  NetworkService.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

enum NetworkService {
    
    case getWeatherForecast(lat: String, lon: String)
    
}

extension NetworkService: TargetType {
    
    var baseURL: String {
        switch self {
        case .getWeatherForecast:
            return "https://api.openweathermap.org"
        }
    }
    
    var path: String {
        switch self {
        case .getWeatherForecast:
            return "/data/2.5/forecast"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getWeatherForecast:
            return .get
        }
    }
    
    var task: NetworkTask {
        switch self {
        case .getWeatherForecast(let lat, let lon):
            return .requestParameters(parameters: ["lat": lat,
                                                   "lon": lon,
                                                   "units": "metric",
                                                   "appid": Constants.Network.appid], encoding: .queryString)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getWeatherForecast:
            return ["Content-Type": "application/json"]
        }
    }
    
}
