//
//  FifthSectionView.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import UIKit

import RxSwift
import SnapKit

final class FifthSectionView: UIView {
    
    // MARK: - UI
    private let humidityView = FifthSectionElementView()
    private let cloudsView = FifthSectionElementView()
    private let windView = FifthSectionElementView()
    private let pressureView = FifthSectionElementView()
    
    // MARK: - Constants
    private let elementOffset = Constants.FifthSectionView.elementOffset
    private let percent = "%"
    private let meterPerSec = "m/s"
    private let hectopascal = "hpa"
    private let humidity = "습도"
    private let clouds = "구름"
    private let wind = "바람 속도"
    private let pressure = "기압"
    
    // MARK: - Instances
    private var viewModel: MainViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpHumidityView()
        setUpCloudsView()
        setUpWindView()
        setUpPressureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - ViewModel
extension FifthSectionView {
    
    func setViewModel(to viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - View
extension FifthSectionView {
    
    private func setUpView() {
        setStyleOfView()
        addSubviews()
    }
    
    private func setStyleOfView() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        [humidityView, cloudsView, windView, pressureView].forEach { addSubview($0) }
    }
    
}

// MARK: - Humidity View
extension FifthSectionView {
    
    private func setUpHumidityView() {
        setConstraintsOfHumidityView()
    }
    
    private func setConstraintsOfHumidityView() {
        humidityView.snp.makeConstraints {
            $0.top.left.equalToSuperview()
            $0.width.equalTo(self.snp.width).offset(-elementOffset/2).dividedBy(2.0)
            $0.height.equalTo(humidityView.snp.width).multipliedBy(1.0)
        }
    }
    
    private func setHumidityView(humidity: String) {
        humidityView.setTitleLabel(to: self.humidity)
        humidityView.setContentLabel(to: humidity + percent)
    }
    
}

// MARK: - Clouds View
extension FifthSectionView {
    
    private func setUpCloudsView() {
        setConstraintsOfCloudsView()
    }
    
    private func setConstraintsOfCloudsView() {
        cloudsView.snp.makeConstraints {
            $0.top.right.equalToSuperview()
            $0.left.equalTo(humidityView.snp.right).offset(elementOffset)
            $0.height.equalTo(cloudsView.snp.width).multipliedBy(1.0)
        }
    }
    
    private func setCloudsView(clouds: String) {
        cloudsView.setTitleLabel(to: self.clouds)
        cloudsView.setContentLabel(to: clouds + percent)
    }
    
}

// MARK: - Wind View
extension FifthSectionView {
    
    private func setUpWindView() {
        setConstraintsOfWindView()
    }
    
    private func setConstraintsOfWindView() {
        windView.snp.makeConstraints {
            $0.top.equalTo(humidityView.snp.bottom).offset(elementOffset)
            $0.left.bottom.equalToSuperview()
            $0.height.equalTo(windView.snp.width).multipliedBy(1.0)
        }
    }
    
    private func setWindView(wind: String) {
        windView.setTitleLabel(to: self.wind)
        windView.setContentLabel(to: wind + meterPerSec)
    }
    
}

// MARK: - Pressure View
extension FifthSectionView {
    
    private func setUpPressureView() {
        setConstraintsOfPressureView()
    }
    
    private func setConstraintsOfPressureView() {
        pressureView.snp.makeConstraints {
            $0.bottom.right.equalToSuperview()
            $0.top.equalTo(cloudsView.snp.bottom).offset(elementOffset)
            $0.left.equalTo(windView.snp.right).offset(elementOffset)
            $0.height.equalTo(pressureView.snp.width).multipliedBy(1.0)
        }
    }
    
    private func setPressureView(pressure: String) {
        pressureView.setTitleLabel(to: self.pressure)
        pressureView.setContentLabel(to: pressure + hectopascal)
    }
    
}

// MARK: - Binding Content
extension FifthSectionView {
    
    func bindFiveDaysForecastTableView() {
        viewModel?.currenWeatherSubject
            .subscribe(onNext: { [weak self] item in
                guard let self = self else { return }
                self.setContent(humidity: String(item.humiditiy), clouds: String(item.clouds), wind: String(item.wind), pressure: String(item.pressure))
            })
            .disposed(by: disposeBag)
    }
    
    private func setContent(humidity: String, clouds: String, wind: String, pressure: String) {
        setHumidityView(humidity: humidity)
        setCloudsView(clouds: clouds)
        setWindView(wind: wind)
        setPressureView(pressure: pressure)
    }
    
}
