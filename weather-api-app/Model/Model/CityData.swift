//
//  CityData.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

struct CityData: Codable {
    
    let id: Int
    let name, country: String
    let coord: Coord
    
}

typealias CityDataList = [CityData]
