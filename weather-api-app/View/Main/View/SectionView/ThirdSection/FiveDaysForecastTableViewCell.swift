//
//  FiveDaysForecastTableViewCell.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import UIKit

import Reusable
import SnapKit

final class FiveDaysForecastTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - UI
    private let dayLabel = UILabel()
    private let weatherImageView = UIImageView()
    private let maxAndMinTemperatureLabel = UILabel()
    
    // MARK: - Constants
    private let superviewInset = Constants.FiveDaysForecastTableViewCell.superviewInset
    private let weatherImageViewSide = Constants.FiveDaysForecastTableViewCell.weatherImageViewSide
    private let elementOffset = Constants.FiveDaysForecastTableViewCell.elementOffset
    private let maxAndMinTemperatureText = { (maxTemperature: String, minTemperature: String) -> String in
        return "최고: \(maxTemperature)° ㅣ 최저: \(minTemperature)°"
    }
    private let dayText = { (day: Int) -> String in
        return day == 0 ? "오늘" : "\(day)일 후"
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpDayLabel()
        setUpWeatherImageView()
        setUpMaxAndMinTemperatureLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - Cell
extension FiveDaysForecastTableViewCell {
    
    private func setUpCell() {
        setStyleOfCell()
        addSubviews()
    }
    
    private func setStyleOfCell() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        [dayLabel, weatherImageView, maxAndMinTemperatureLabel].forEach { addSubview($0) }
    }
    
}

// MARK: - Day Label
extension FiveDaysForecastTableViewCell {
    
    private func setUpDayLabel() {
        setStyleOfDayLabel()
        setConstraintsOfDayLabel()
    }
    
    private func setStyleOfDayLabel() {
        dayLabel.textAlignment = .center
        dayLabel.textColor = .white
        dayLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoRegular, size: 15)
    }
    
    private func setConstraintsOfDayLabel() {
        dayLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(superviewInset)
            $0.leading.equalToSuperview()
            $0.width.equalTo(40)
        }
    }
    
    private func setDayLabel(to day: String) {
        dayLabel.text = day
    }
    
}

// MARK: - Weather ImageView
extension FiveDaysForecastTableViewCell {
    
    private func setUpWeatherImageView() {
        setStyleOfWeatherImageView()
        setConstraintsOfWeatherImageView()
    }
    
    private func setStyleOfWeatherImageView() {
        weatherImageView.backgroundColor = .clear
    }
    
    private func setConstraintsOfWeatherImageView() {
        weatherImageView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(dayLabel.snp.right).offset(50)
            $0.width.height.equalTo(weatherImageViewSide)
        }
    }
    
    private func setWeatherImageView(to image: UIImage) {
        weatherImageView.image = image
    }
    
}

// MARK: - Max and Min Temperature Label
extension FiveDaysForecastTableViewCell {
    
    private func setUpMaxAndMinTemperatureLabel() {
        setStyleOfMaxAndMinTemperatureLabel()
        setConstraintsOfMaxAndMinTemperatureLabel()
    }
    
    private func setStyleOfMaxAndMinTemperatureLabel() {
        maxAndMinTemperatureLabel.textAlignment = .center
        maxAndMinTemperatureLabel.textColor = .white
        maxAndMinTemperatureLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoRegular, size: 15)
    }
    
    private func setConstraintsOfMaxAndMinTemperatureLabel() {
        maxAndMinTemperatureLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(superviewInset)
            $0.right.equalToSuperview()
        }
    }
    
    private func setMaxAndMinTemperatureLabel(maxTemperature: String, minTemperature: String) {
        maxAndMinTemperatureLabel.text = maxAndMinTemperatureText(maxTemperature, minTemperature)
    }
    
}

// MARK: - Set content
extension FiveDaysForecastTableViewCell {
    
    func setContent(day: Int, weatherImage: UIImage, maxTemperature: String, minTemperature: String) {
        let day = dayText(day)
        setDayLabel(to: day)
        setWeatherImageView(to: weatherImage)
        setMaxAndMinTemperatureLabel(maxTemperature: maxTemperature, minTemperature: minTemperature)
    }
    
}
