//
//  SecondSectionView.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import UIKit

import Reusable
import RxSwift
import RxCocoa
import SnapKit

final class SecondSectionView: UIView {
    
    // MARK: - UI
    private let threeHoursForecastCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    // MARK: - Constants
    private let cellSize = Constants.ThreeHoursForecastCollectionViewCell.cellSize
    private let superviewInset = Constants.SecondSectionView.superviewInset
    
    // MARK: - Instances
    private var viewModel: MainViewModel?
    private let disposeBag = DisposeBag()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpThreeHoursForecastCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - ViewModel
extension SecondSectionView {
    
    func setViewModel(to viewModel: MainViewModel) {
        self.viewModel = viewModel
    }
    
}

// MARK: - View
extension SecondSectionView {
    
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
        [threeHoursForecastCollectionView].forEach { addSubview($0) }
    }
    
}

// MARK: - Three Hours Forecast CollectionView
extension SecondSectionView: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    private func setUpThreeHoursForecastCollectionView() {
        setStyleOfThreeHoursForecastCollectionView()
        setConstraintsOfThreeHoursForecastCollectionView()
        configureThreeHoursForecastCollectionView()
    }
    
    private func setStyleOfThreeHoursForecastCollectionView() {
        threeHoursForecastCollectionView.backgroundColor = .clear
    }
    
    private func setConstraintsOfThreeHoursForecastCollectionView() {
        threeHoursForecastCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(superviewInset)
        }
    }
    
    private func configureThreeHoursForecastCollectionView() {
        threeHoursForecastCollectionView.register(cellType: ThreeHoursForecastCollectionViewCell.self)
        threeHoursForecastCollectionView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    // MARK: - Delegate Methods
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize
    }
    
}

// MARK: - Binding Content
extension SecondSectionView {
    
    func bindThreeHoursForecastCollectionView() {
        viewModel?.threeHoursWeatherListSubject
            .bind(to: threeHoursForecastCollectionView.rx.items(cellIdentifier: ThreeHoursForecastCollectionViewCell.reuseIdentifier, cellType: ThreeHoursForecastCollectionViewCell.self)) { index, item, cell in
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
                cell.setContent(time: index * 3, weatherImage: weatherImage, temperature: String(item.currentTemperature))
            }
            .disposed(by: disposeBag)
    }
    
}
