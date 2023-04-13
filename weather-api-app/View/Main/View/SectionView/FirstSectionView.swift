//
//  FirstSectionView.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import UIKit

import SnapKit
import RxSwift

final class FirstSectionView: UIView {
    
    // MARK: - UI
    private let cityNameLabel = UILabel()
    private let currentTemperatureLabel = UILabel()
    private let weatherLabel = UILabel()
    private let maxAndMinTemperatureLabel = UILabel()
    
    // MARK: - Instances
    private var viewModel: MainViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    private let degree = "°"
    private let maxAndMinTemperatureText = { (maxTemperature: String, minTemperature: String) -> String in
        return "최고: \(maxTemperature)° ㅣ 최저: \(minTemperature)°"
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpCityNameLabel()
        setUpCurrentTemperatureLabel()
        setUpWeatherLabel()
        setUpMaxandMinTemperatureLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - ViewModel
extension FirstSectionView {
    
    func setViewModel(to viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - View
extension FirstSectionView {
    
    private func setUpView() {
        setStyleOfView()
        addSubviews()
    }
    
    private func setStyleOfView() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        [cityNameLabel, currentTemperatureLabel, weatherLabel, maxAndMinTemperatureLabel]
            .forEach { addSubview($0) }
    }
    
}

// MARK: - City Name Label
extension FirstSectionView {
    
    private func setUpCityNameLabel() {
        setStyleOfCityNameLabel()
        setConstraintsOfCityNameLabel()
    }
    
    private func setStyleOfCityNameLabel() {
        cityNameLabel.backgroundColor = .clear
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = .white
        cityNameLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoSemiBold, size: 30)
    }
    
    private func setConstraintsOfCityNameLabel() {
        cityNameLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
    }
    
    private func setContentOfCityNameLabel(to cityName: String) {
        cityNameLabel.text = cityName
    }
    
}

// MARK: - Current Temperature Label
extension FirstSectionView {
    
    private func setUpCurrentTemperatureLabel() {
        setStyleOfCurrentTemperatureLabel()
        setConstraintsOfCurrentTemperatureLabel()
    }
    
    private func setStyleOfCurrentTemperatureLabel() {
        currentTemperatureLabel.backgroundColor = .clear
        currentTemperatureLabel.textAlignment = .center
        currentTemperatureLabel.textColor = .white
        currentTemperatureLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoBold, size: 50)
    }
    
    private func setConstraintsOfCurrentTemperatureLabel() {
        currentTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(cityNameLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setContentOfCurrentTemperatureLabel(to currentTemperature: String) {
        currentTemperatureLabel.text = currentTemperature + degree
    }
    
}

// MARK: - Weather Label
extension FirstSectionView {
    
    private func setUpWeatherLabel() {
        setStyleOfWeatherLabel()
        setConstraintsOfWeatherLabel()
    }
    
    private func setStyleOfWeatherLabel() {
        weatherLabel.backgroundColor = .clear
        weatherLabel.textAlignment = .center
        weatherLabel.textColor = .white
        weatherLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoSemiBold, size: 20)
    }
    
    private func setConstraintsOfWeatherLabel() {
        weatherLabel.snp.makeConstraints {
            $0.top.equalTo(currentTemperatureLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setContentOfWeatherLabel(to weather: String) {
        weatherLabel.text = weather
    }
    
}

// MARK: - Max and Min Temperature Label
extension FirstSectionView {
    
    private func setUpMaxandMinTemperatureLabel() {
        setStyleOfMaxandMinTemperatureLabel()
        setConstraintsOfMaxandMinTemperatureLabel()
    }
    
    private func setStyleOfMaxandMinTemperatureLabel() {
        maxAndMinTemperatureLabel.backgroundColor = .clear
        maxAndMinTemperatureLabel.textAlignment = .center
        maxAndMinTemperatureLabel.textColor = .white
        maxAndMinTemperatureLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoSemiBold, size: 17)
    }
    
    private func setConstraintsOfMaxandMinTemperatureLabel() {
        maxAndMinTemperatureLabel.snp.makeConstraints {
            $0.top.equalTo(weatherLabel.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setContentOfMaxandMinTemperatureLabel(maxTemperature: String, minTemperature: String) {
        maxAndMinTemperatureLabel.text = maxAndMinTemperatureText(maxTemperature, minTemperature)
    }
    
}

// MARK: - Binding Content
extension FirstSectionView {
    
    func bindContent() {
        viewModel?.currenWeatherSubject
            .bind(onNext: { [weak self] weatherItem in
                guard let self = self else { return }
                self.setContent(cityName: weatherItem.cityName,
                                currentTemperature: String(weatherItem.currentTemperature),
                                weather: weatherItem.weather.description,
                                maxTemperature: String(weatherItem.maxTemperature),
                                minTemperature: String(weatherItem.minTemperature))
            })
            .disposed(by: disposeBag)
    }
    
    private func setContent(cityName: String, currentTemperature: String, weather: String, maxTemperature: String, minTemperature: String) {
        setContentOfCityNameLabel(to: cityName)
        setContentOfCurrentTemperatureLabel(to: currentTemperature)
        setContentOfWeatherLabel(to: weather)
        setContentOfMaxandMinTemperatureLabel(maxTemperature: maxTemperature, minTemperature: minTemperature)
    }
    
}
