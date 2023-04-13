//
//  LocalResourceManager.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

import RxSwift

struct LocalResourceManager { }

// MARK: - Functions
extension LocalResourceManager {
    
    // MARK: - Local Resources
    func getCityDataList() -> Observable<CityDataList> {
        return Observable.create { emitter in
            do {
                let cityJSONData = try loadJSONFile(fileName: Constants.Network.citylistFileName)
                let cityDataList = try DataManager.shared.decodeData(from: cityJSONData, to: CityDataList.self)
                emitter.onNext(cityDataList)
            } catch {
                emitter.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Logics
    private func loadJSONFile(fileName: String) throws -> Data {
        guard let fileLocation = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            throw LocalResourceError.notFindingResource
        }
        do {
            return try Data(contentsOf: fileLocation)
        } catch {
            throw DataError.nonData
        }
    }
    
}
