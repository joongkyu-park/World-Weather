//
//  DataManager.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

import RxSwift

struct DataManager {
    
    // MARK: - Singleton
    static let shared = DataManager()
    private init() { }
    
    // MARK: - Instances
    private let networkManager = NetworkManager()
    private let localResourceManager = LocalResourceManager()
    
}

// MARK: - Functions
extension DataManager {
    
    // MARK: - Fetching Data
    func fetchWeatherData(lat: String, lon: String) -> Observable<WeatherData> {
        return networkManager.getWeatherData(lat: lat, lon: lon)
    }
    
    func fetchCityDataList() -> Observable<CityDataList> {
        return localResourceManager.getCityDataList()
    }
    
    // MARK: - Logics
    func decodeData<T: Codable>(from data: Data?, to type: T.Type) throws -> T {
        guard let data = data else {
            throw DataError.nonData
        }
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else {
            throw DataError.decodeError(toType: T.self)
        }
        return decodedData
    }
    
}
