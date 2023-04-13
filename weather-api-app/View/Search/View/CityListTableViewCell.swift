//
//  CityListTableViewCell.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/19.
//

import UIKit

import Reusable
import SnapKit

final class CityListTableViewCell: UITableViewCell, Reusable {
    
    // MARK: - UI
    private let cityLabel = UILabel()
    private let countryLabel = UILabel()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpCell()
        setUpCityLabel()
        setUpCountryLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - Cell
extension CityListTableViewCell {
    
    private func setUpCell() {
        setStyleOfCell()
        addSubviews()
    }
    
    private func setStyleOfCell() {
        backgroundColor = .clear
    }
    
    private func addSubviews() {
        [cityLabel, countryLabel].forEach { addSubview($0) }
    }
    
}

// MARK: - City Label
extension CityListTableViewCell {
    
    private func setUpCityLabel() {
        setStyleOfCityLabel()
        setConstraintsOfCityLabel()
    }
    
    private func setStyleOfCityLabel() {
        cityLabel.textAlignment = .left
        cityLabel.textColor = .white
        cityLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoSemiBold, size: 20)
    }
    
    private func setConstraintsOfCityLabel() {
        cityLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.left.right.equalToSuperview()
        }
    }
    
    private func setCityLabel(to city: String) {
        cityLabel.text = city
    }
    
}

// MARK: - Country Label
extension CityListTableViewCell {
    
    private func setUpCountryLabel() {
        setStyleOfCountryLabel()
        setConstraintsOfCountryLabel()
    }
    
    private func setStyleOfCountryLabel() {
        countryLabel.textAlignment = .left
        countryLabel.textColor = .white
        countryLabel.font = UIFont(name: Constants.FontName.appleSDGothicNeoRegular, size: 15)
    }
    
    private func setConstraintsOfCountryLabel() {
        countryLabel.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(cityLabel.snp.bottom).offset(10)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setCountryLabel(to country: String) {
        countryLabel.text = country
    }
    
}

// MARK: - Set content
extension CityListTableViewCell {
    
    func setContent(city: String, country: String) {
        setCityLabel(to: city)
        setCountryLabel(to: country)
    }
    
}
