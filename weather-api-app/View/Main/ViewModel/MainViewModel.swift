//
//  MainViewModel.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/19.
//

import Foundation

import RxSwift

final class MainViewModel {
    
    // MARK: - Properties
    private var currentCityData = Constants.Model.defaultCityData
    
    // MARK: - Instances
    private let disposeBag = DisposeBag()
    
    // MARK: - Observables
    let currenWeatherSubject = PublishSubject<WeatherItem>()
    let threeHoursWeatherListSubject = PublishSubject<[WeatherItem]>()
    let fiveDaysWeatherListSubject = PublishSubject<[WeatherItem]>()
    
    // MARK: - Initializer
    init() {
        fetchWeatherData(from: currentCityData)
    }
}

// MARK: - Functions
extension MainViewModel {
    
    // MARK: - Network
    func fetchWeatherData(from cityData: CityData) {
        DataManager.shared.fetchWeatherData(lat: String(cityData.coord.lat), lon: String(cityData.coord.lon))
            .subscribe(onNext: { [weak self] weatherData in
                guard let self = self else { return }
                let weatherItemList = self.createWeatherItemList(from: weatherData)
                self.currenWeatherSubject.onNext(weatherItemList[0])
                self.threeHoursWeatherListSubject.onNext(Array(weatherItemList[0..<16]))
                let fiveDaysWeatherItemList = self.createFiveDaysWeatherItemList(from: weatherItemList)
                self.fiveDaysWeatherListSubject.onNext(fiveDaysWeatherItemList)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Logics
    private func createWeatherItemList(from weatherData: WeatherData) -> [WeatherItem] {
        return weatherData.list.map { WeatherItem(cityName: weatherData.city.name,
                                           currentTemperature: $0.main.temp,
                                           weather: $0.weather[0].main,
                                           maxTemperature: $0.main.tempMax,
                                           minTemperature: $0.main.tempMin,
                                           humiditiy: $0.main.humidity,
                                           clouds: $0.clouds.all,
                                           wind: $0.wind.speed,
                                           pressure: $0.main.pressure) }
    }
    
    private func createFiveDaysWeatherItemList(from weatherItemList: [WeatherItem]) -> [WeatherItem] {
        weatherItemList.enumerated().filter { index, _ in
            return index % 8 == 0
        }.map { _, item in
            return item
        }
    }
    
}
