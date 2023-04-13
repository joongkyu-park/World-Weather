//
//  WeatherData.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

struct WeatherData: Codable {
    
    let cod: String
    let message, cnt: Int
    let list: [List]
    let city: City
    
}

struct City: Codable {
    
    let id, population, timezone, sunrise, sunset: Int
    let name, country: String
    let coord: Coord
    
}

struct Coord: Codable {
    
    let lat, lon: Double
    
}

struct List: Codable {
    
    let time, visibility: Int
    let main: MainInfo
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let pop: Double
    let rain: Rain?
    let sys: Sys
    let dtTxt: String
    let snow: Snow?

    enum CodingKeys: String, CodingKey {
        case main, weather, clouds, wind, visibility, pop, rain, sys, snow
        case dtTxt = "dt_txt"
        case time = "dt"
    }
    
}

struct Clouds: Codable {
    
    let all: Int
    
}

struct MainInfo: Codable {
    
    let temp, feelsLike, tempMin, tempMax, tempKf: Double
    let pressure, seaLevel, grndLevel, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
}

struct Rain: Codable {
    
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
    
}

struct Snow: Codable {
    
    let the3H: Double

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
    
}

struct Sys: Codable {
    
    let pod: Pod
    
}

enum Pod: String, Codable {
    
    case day = "d"
    case night = "n"
    
}

struct Weather: Codable {
    
    let id: Int
    let main: WeatherType
    let description, icon: String
    
}

enum WeatherType: String, Codable {
    
    case clear = "Clear"
    case clouds = "Clouds"
    case rain = "Rain"
    case snow = "Snow"
    
    var description: String {
        switch self {
        case .clear:
            return "맑음"
        case .clouds:
            return "흐림"
        case .rain:
            return "비"
        case .snow:
            return "눈"
        }
    }
    
}

struct Wind: Codable {
    
    let speed: Double
    let deg: Int
    let gust: Double
    
}

struct WeatherItem {
    
    let cityName: String
    let currentTemperature: Double
    let weather: WeatherType
    let maxTemperature: Double
    let minTemperature: Double
    let humiditiy: Int
    let clouds: Int
    let wind: Double
    let pressure: Int
    
}
