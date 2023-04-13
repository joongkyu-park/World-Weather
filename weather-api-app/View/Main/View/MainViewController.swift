//
//  MainViewController.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/16.
//

import UIKit

import SnapKit

final class MainViewController: UIViewController {
    
    // MARK: - UI
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let searchBar = UISearchBar()
    private let searchAreaButton = UIButton()
    private let firstSectionView = FirstSectionView()
    private let secondSectionView = SecondSectionView()
    private let thirdSectionView = ThirdSectionView()
    private let fourthSectionView = FourthSectionView()
    private let fifthSectionView = FifthSectionView()
    
    // MARK: - Constants
    private let elementOffset = Constants.MainViewController.elementOffset
    private let secondSectionViewHeight = Constants.MainViewController.secondSectionViewHeight
    private let thirdSectionViewHeight = Constants.MainViewController.thirdSectionViewHeight
    private let searchBarPlaceHolder = "Search"
    
    // MARK: - Instances
    private let viewModel = MainViewModel()
    private var searchViewController: SearchViewController {
        let searchViewController = SearchViewController()
        searchViewController.modalTransitionStyle = .coverVertical
        searchViewController.modalPresentationStyle = .fullScreen
        searchViewController.setMainViewController(self)
        return searchViewController
    }
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpViewController()
        setUpScrollView()
        setUpContentView()
        setUpSearchBar()
        setUpSearchAreaButton()
        setUpFirstSectionView()
        setUpSecondSectionView()
        setUpThirdSectionView()
        setUpFourthSectionView()
        setUpFifthSectionView()
    }
    
}

// MARK: - ViewController
extension MainViewController {
    
    private func setUpViewController() {
        setStyleOfViewController()
        addSubviews()
    }
    
    private func setStyleOfViewController() {
        view.backgroundColor = Constants.Color.mainBackground
    }
    
    private func addSubviews() {
        view.addSubview(scrollView)
    }
    
}

// MARK: - Scroll View
extension MainViewController {
    
    private func setUpScrollView() {
        setConstraintsOfScrollView()
        addSubviewOfScrollView()
    }
    
    private func setConstraintsOfScrollView() {
        scrollView.snp.makeConstraints {
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    private func addSubviewOfScrollView() {
        scrollView.addSubview(contentView)
    }
    
}

// MARK: - Content View
extension MainViewController {
    
    private func setUpContentView() {
        setStyleOfContentView()
        setConstraintsOfContentView()
        addSubviewOfContentView()
    }
    
    private func setStyleOfContentView() {
        contentView.backgroundColor = .clear
    }
    
    private func setConstraintsOfContentView() {
        contentView.snp.makeConstraints {
            $0.edges.width.equalToSuperview()
        }
    }
    
    private func addSubviewOfContentView() {
        [searchBar, searchAreaButton, firstSectionView, secondSectionView, thirdSectionView, fourthSectionView, fifthSectionView].forEach { contentView.addSubview($0) }
    }
    
}

// MARK: - Search Bar
extension MainViewController {
    
    private func setUpSearchBar() {
        setStyleOfSearchBar()
        setConstraintsOfSearchBar()
        configureSearchBar()
    }
    
    private func setStyleOfSearchBar() {
        searchBar.backgroundImage = UIImage()
        searchBar.searchTextField.backgroundColor = Constants.Color.searchBar
        searchBar.placeholder = searchBarPlaceHolder
    }
    
    private func setConstraintsOfSearchBar() {
        searchBar.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.centerX.top.equalToSuperview()
        }
    }
    
    private func configureSearchBar() {
        searchBar.isUserInteractionEnabled = false
    }
    
}

// MARK: - Search Area Button
extension MainViewController {
    
    func setUpSearchAreaButton() {
        setStyleOfSearchAreaButton()
        setConstraintsOfSearchAreaButton()
        configureSearchAreaButton()
    }
    
    func setStyleOfSearchAreaButton() {
        searchAreaButton.backgroundColor = .clear
    }
    
    func setConstraintsOfSearchAreaButton() {
        searchAreaButton.snp.makeConstraints {
            $0.edges.equalTo(searchBar.snp.edges)
            $0.width.height.equalTo(searchBar)
        }
    }
    
    func configureSearchAreaButton() {
        searchAreaButton.addTarget(self, action: #selector(searchAreaButtonDidTapped), for: .touchUpInside)
    }
    
    @objc
    func searchAreaButtonDidTapped() {
        present(searchViewController, animated: true)
    }
    
}

// MARK: - First Section View
extension MainViewController {
    
    private func setUpFirstSectionView() {
        setConstraintsOfFirstSectionView()
        firstSectionView.setViewModel(to: viewModel)
        firstSectionView.bindContent()
    }
    
    private func setConstraintsOfFirstSectionView() {
        firstSectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(elementOffset)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
}

// MARK: - Second Section View
extension MainViewController {
    
    private func setUpSecondSectionView() {
        setConstraintsOfSecondSectionView()
        secondSectionView.setViewModel(to: viewModel)
        secondSectionView.bindThreeHoursForecastCollectionView()
    }
    
    private func setConstraintsOfSecondSectionView() {
        secondSectionView.snp.makeConstraints {
            $0.top.equalTo(firstSectionView.snp.bottom).offset(elementOffset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(secondSectionViewHeight)
        }
    }
    
}

// MARK: - Third Section View
extension MainViewController {
    
    private func setUpThirdSectionView() {
        setConstraintsOfThirdSectionView()
        thirdSectionView.setViewModel(to: viewModel)
        thirdSectionView.bindFiveDaysForecastTableView()
    }
    
    private func setConstraintsOfThirdSectionView() {
        thirdSectionView.snp.makeConstraints {
            $0.top.equalTo(secondSectionView.snp.bottom).offset(elementOffset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(thirdSectionViewHeight)
        }
    }
    
}

// MARK: - Fourth Section View
extension MainViewController {
    
    private func setUpFourthSectionView() {
        setConstraintsOfFourthSectionView()
        fourthSectionView.setMapView(by: Constants.Model.defaultCityData)
    }
    
    private func setConstraintsOfFourthSectionView() {
        fourthSectionView.snp.makeConstraints {
            $0.top.equalTo(thirdSectionView.snp.bottom).offset(elementOffset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.width)
        }
    }
    
}

// MARK: - Fifth Section View
extension MainViewController {
    
    private func setUpFifthSectionView() {
        setConstraintsOfFifthSectionView()
        fifthSectionView.setViewModel(to: viewModel)
        fifthSectionView.bindFiveDaysForecastTableView()
    }
    
    private func setConstraintsOfFifthSectionView() {
        fifthSectionView.snp.makeConstraints {
            $0.top.equalTo(fourthSectionView.snp.bottom).offset(elementOffset)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(contentView.snp.width)
            $0.bottom.equalToSuperview()
        }
    }
    
}

// MARK: - Set New Weather Data
extension MainViewController {
    func setNewWeatherData(with cityData: CityData) {
        viewModel.fetchWeatherData(from: cityData)
        fourthSectionView.setMapView(by: cityData)
    }
}
