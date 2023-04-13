//
//  SearchViewModel.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/19.
//

import Foundation

import RxSwift

final class SearchViewModel {
    
    // MARK: - Instances
    private let disposeBag = DisposeBag()
    
    // MARK: - Observables
    let cityDataListSubject = BehaviorSubject<CityDataList>(value: [])
    
    // MARK: - Properites
    private(set) var cityDataList: CityDataList = []
    
    // MARK: - Initializer
    init() {
        fetchCityDataList()
    }
    
}

// MARK: - Functions
extension SearchViewModel {
    
    // MARK: - Fetching JSON File Data
    private func fetchCityDataList() {
        DataManager.shared.fetchCityDataList()
            .subscribe(onNext: { [weak self] cityDataList in
                guard let self = self else { return }
                self.cityDataListSubject.onNext(cityDataList)
                self.setCityDataList(to: cityDataList)
            })
            .disposed(by: disposeBag)
    }
    
    func fetchCityDataList(searchTerm: String) {
        if searchTerm == "" {
            fetchCityDataList()
            return
        }
        DataManager.shared.fetchCityDataList()
            .subscribe(onNext: { [weak self] cityDataList in
                guard let self = self else { return }
                let searchedCityDataList = self.search(cityDataList: cityDataList, for: searchTerm)
                self.cityDataListSubject.onNext(searchedCityDataList)
                self.setCityDataList(to: searchedCityDataList)
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: - Set Properites
    private func setCityDataList(to cityDataList: [CityData]) {
        self.cityDataList = cityDataList
    }
    
    // MARK: - Logics
    private func search(cityDataList: [CityData], for searchTerm: String) -> [CityData] {
        return cityDataList.filter { $0.name.contains(searchTerm) || $0.country.contains(searchTerm) }
    }
    
}
