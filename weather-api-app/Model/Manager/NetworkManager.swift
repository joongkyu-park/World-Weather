//
//  NetworkManager.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

import Alamofire
import RxSwift

struct NetworkManager {
    
    // MARK: - Instances
    private let provider = NetworkProvider<NetworkService>()
    
}

// MARK: - Functions
extension NetworkManager {
    
    // MARK: - REST API Request
    func getWeatherData(lat: String, lon: String) -> Observable<WeatherData> {
        return Observable.create { emitter in
            do {
                let request = try provider.request(.getWeatherForecast(lat: lat, lon: lon))
                AF.request(request).responseString { response in
                    switch response.result {
                    case .success:
                        do {
                            let weatherData = try self.judgeStatus(by: response.response?.statusCode, response.data, type: WeatherData.self)
                            emitter.onNext(weatherData)
                        } catch let error {
                            emitter.onError(error)
                        }
                    case .failure(let error):
                        emitter.onError(error)
                    }
                }
            } catch {
                emitter.onError(error)
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Logics
    private func judgeStatus<T: Codable>(by statusCode: Int?, _ data: Data?, type: T.Type) throws -> T {
        guard let statusCode = statusCode else {
            throw NetworkError.nonStatusCode
        }
        switch statusCode {
        case 200:
            return try DataManager.shared.decodeData(from: data, to: type)
        case 400..<500:
            throw NetworkError.requestError(statusCode)
        case 500:
            throw NetworkError.serverError(statusCode)
        default:
            throw NetworkError.networkFailError(statusCode)
        }
    }
    
}
