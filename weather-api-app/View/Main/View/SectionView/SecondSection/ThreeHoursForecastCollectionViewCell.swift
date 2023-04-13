//
//  ThreeHoursForecastCollectionViewCell.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import UIKit

import Reusable
import SnapKit

final class ThreeHoursForecastCollectionViewCell: UICollectionViewCell, Reusable {
    
    // MARK: - UI
    private let timeLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let temperatureLabel = UILabel()
    
    // MARK: - Constants
    private let superviewInset: CGFloat = Constants.ThreeHoursForecastCollectionViewCell.superviewInset
    private let elementOffset: CGFloat = Constants.ThreeHoursForecastCollectionViewCell.elementOffset
    private let labelWidth: CGFloat = Constants.ThreeHoursForecastCollectionViewCell.labelWidth
    private let labelHeight: CGFloat = Constants.ThreeHoursForecastCollectionViewCell.labelHeight
    private let weatherImageViewSide: CGFloat = Constants.ThreeHoursForecastCollectionViewCell.weatherImageViewSide
    private let cellSize = Constants.ThreeHoursForecastCollectionViewCell.cellSize
    private let degree = "°"
    private let timeText = { (time: Int) -> String in
        return time == 0 ? "지금" : "\(time)시간 후"
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpCell()
        setUpTimeLabel()
        setUpWeatherImageView()
        setUpTemperatureLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - Cell
extension ThreeHoursForecastCollectionViewCell {
    
    private func setUpCell() {
        setStyleOfCell()
        addSubviews()
    }
    
    private func setStyleOfCell() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        [timeLabel, weatherImageView, temperatureLabel].forEach { addSubview($0) }
    }
    
}

// MARK: - Time Label
extension ThreeHoursForecastCollectionViewCell {
    
    private func setUpTimeLabel() {
        setStyleOfTimeLabel()
        setConstraintsOfTimeLabel()
    }
    
    private func setStyleOfTimeLabel() {
        timeLabel.textAlignment = .center
        timeLabel.textColor = .white
        timeLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoRegular, size: 15)
    }
    
    private func setConstraintsOfTimeLabel() {
        timeLabel.snp.makeConstraints {
            $0.top.left.right.equalToSuperview().inset(superviewInset)
            $0.width.equalTo(labelWidth)
            $0.height.equalTo(labelHeight)
        }
    }
    
    private func setTimeLabel(to time: String) {
        timeLabel.text = time
    }
    
}

// MARK: - Weather ImageView
extension ThreeHoursForecastCollectionViewCell {
    
    private func setUpWeatherImageView() {
        setStyleOfWeatherImageView()
        setConstraintsOfWeatherImageView()
    }
    
    private func setStyleOfWeatherImageView() {
        weatherImageView.backgroundColor = .clear
    }
    
    private func setConstraintsOfWeatherImageView() {
        weatherImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(timeLabel.snp.bottom).offset(elementOffset)
            $0.width.height.equalTo(weatherImageViewSide)
        }
    }
    
    private func setWeatherImageView(to image: UIImage) {
        weatherImageView.image = image
    }
    
}

// MARK: - Temperature Label
extension ThreeHoursForecastCollectionViewCell {
    
    private func setUpTemperatureLabel() {
        setStyleOfTemperatureLabel()
        setConstraintsOfTemperatureLabel()
    }
    
    private func setStyleOfTemperatureLabel() {
        temperatureLabel.textAlignment = .center
    }
    
    private func setConstraintsOfTemperatureLabel() {
        temperatureLabel.snp.makeConstraints {
            $0.left.right.equalTo(timeLabel)
            $0.top.equalTo(weatherImageView.snp.bottom).offset(elementOffset)
            $0.bottom.equalToSuperview().inset(superviewInset)
            $0.width.equalTo(labelWidth)
            $0.height.equalTo(labelHeight)
        }
    }
    
    private func setTemperatureLabel(to temperature: String) {
        temperatureLabel.text = temperature + degree
        temperatureLabel.textColor = .white
        temperatureLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoRegular, size: 15)
    }
    
}

// MARK: - Set content
extension ThreeHoursForecastCollectionViewCell {
    
    func setContent(time: Int, weatherImage: UIImage, temperature: String) {
        let time = timeText(time)
        setTimeLabel(to: time)
        setWeatherImageView(to: weatherImage)
        setTemperatureLabel(to: temperature)
    }
    
}
