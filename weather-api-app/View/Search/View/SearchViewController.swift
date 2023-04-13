//
//  SearchViewController.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/16.
//

import UIKit

import Reusable
import RxCocoa
import RxSwift
import SnapKit

final class SearchViewController: UIViewController {
    
    // MARK: - UI
    private let searchBar = UISearchBar()
    private let cityListTableView = UITableView()
    
    // MARK: - Instances
    private var mainViewController: MainViewController?
    private let viewModel = SearchViewModel()
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    private let searchBarPlaceHolder = "Search"
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViewController()
        setUpSearchBar()
        setUpCityListTableView()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
    
}

// MARK: - ViewController
extension SearchViewController {
    
    private func setUpViewController() {
        setStyleOfViewController()
        addSubviews()
    }
    
    private func setStyleOfViewController() {
        view.backgroundColor = Constants.Color.mainBackground
    }
    
    private func addSubviews() {
        [searchBar, cityListTableView].forEach { view.addSubview($0) }
    }
    
    func setMainViewController(_ mainViewController: MainViewController) {
        self.mainViewController = mainViewController
    }
    
}

// MARK: - Search Bar
extension SearchViewController: UISearchBarDelegate {
    
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
            $0.left.right.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    private func configureSearchBar() {
        searchBar.delegate = self
    }
    
    // MARK: - Delegate Methods
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.fetchCityDataList(searchTerm: searchBar.text ?? "")
        searchBar.resignFirstResponder()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - City List TableView
extension SearchViewController: UITableViewDelegate {
    
    private func setUpCityListTableView() {
        setStyleOfCityListTableView()
        setConstraintsOfCityListTableView()
        configureCityListTableView()
        bindCityListTableView()
    }
    
    private func setStyleOfCityListTableView() {
        cityListTableView.backgroundColor = .clear
    }
    
    private func setConstraintsOfCityListTableView() {
        cityListTableView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom).offset(20)
            $0.left.right.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func configureCityListTableView() {
        cityListTableView.register(cellType: CityListTableViewCell.self)
        cityListTableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    
    private func bindCityListTableView() {
        viewModel.cityDataListSubject
            .bind(to: cityListTableView.rx.items(cellIdentifier: CityListTableViewCell.reuseIdentifier, cellType: CityListTableViewCell.self)) { _, item, cell in
                cell.setContent(city: item.name, country: item.country)
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Delegate Methods
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.dismiss(animated: true) { [weak self] in
            guard let self = self else { return }
            let cityData = self.viewModel.cityDataList[indexPath.row]
            self.mainViewController?.setNewWeatherData(with: cityData)
        }
    }
    
}
