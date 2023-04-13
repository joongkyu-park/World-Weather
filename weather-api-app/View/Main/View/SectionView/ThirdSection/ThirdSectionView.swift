//
//  ThirdSectionView.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import UIKit

import Reusable
import RxSwift
import RxCocoa
import SnapKit

final class ThirdSectionView: UIView {
    
    // MARK: - UI
    private let fiveDaysForecastTableView = UITableView()
    
    // MARK: - Constants
    private let superviewInset = Constants.ThirdSectionView.superviewInset
    
    // MARK: - Instances
    private var viewModel: MainViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpFiveDaysForecastTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - ViewModel

extension ThirdSectionView {
    
    func setViewModel(to viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - View
extension ThirdSectionView {
    
    private func setUpView() {
        setStyleOfView()
        addSubviews()
    }
    
    private func setStyleOfView() {
        backgroundColor = Constants.Color.mainSection
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    private func addSubviews() {
        [fiveDaysForecastTableView].forEach { addSubview($0) }
    }
    
}

// MARK: - Five Days Forecast TableView
extension ThirdSectionView {
    
    private func setUpFiveDaysForecastTableView() {
        setStyleOfFiveDaysForecastTableView()
        setConstraintsOfFiveDaysForecastTableView()
        configureFiveDaysForecastTableView()
    }
    
    private func setStyleOfFiveDaysForecastTableView() {
        fiveDaysForecastTableView.allowsSelection = false
        fiveDaysForecastTableView.isScrollEnabled = false
        fiveDaysForecastTableView.backgroundColor = .clear
    }
    
    private func setConstraintsOfFiveDaysForecastTableView() {
        fiveDaysForecastTableView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(superviewInset)
        }
    }
    
    private func configureFiveDaysForecastTableView() {
        fiveDaysForecastTableView.register(cellType: FiveDaysForecastTableViewCell.self)
    }
    
}

// MARK: - Binding Content
extension ThirdSectionView {
    
    func bindFiveDaysForecastTableView() {
        viewModel?.fiveDaysWeatherListSubject
            .bind(to: fiveDaysForecastTableView.rx.items(cellIdentifier: FiveDaysForecastTableViewCell.reuseIdentifier, cellType: FiveDaysForecastTableViewCell.self)) { index, item, cell in
                let weatherImage: UIImage = {
                    switch item.weather {
                    case .clear:
                        return Constants.Image.clear
                    case .clouds:
                        return Constants.Image.clouds
                    case .rain:
                        return Constants.Image.rain
                    case .snow:
                        return Constants.Image.snow
                    }
                }()
                cell.setContent(day: index, weatherImage: weatherImage, maxTemperature: String(item.maxTemperature), minTemperature: String(item.minTemperature))
            }
            .disposed(by: disposeBag)
    }
    
}
