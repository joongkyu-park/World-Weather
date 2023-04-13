//
//  FourthSectionView.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/18.
//

import UIKit
import MapKit

import SnapKit

final class FourthSectionView: UIView {
    
    // MARK: - UI
    private let mapView = MKMapView()
    
    // MARK: - Constants
    private let superviewInset = Constants.FourthSectionView.superviewInset
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
        setUpMapView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

// MARK: - View
extension FourthSectionView {
    
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
        [mapView].forEach { addSubview($0) }
    }
    
}

// MARK: - MapView
extension FourthSectionView {
    
    private func setUpMapView() {
        setConstraintsOfMapView()
        setStyleOfMapView()
    }
    
    private func setStyleOfMapView() {
        mapView.clipsToBounds = true
        mapView.layer.cornerRadius = 5
    }
    
    private func setConstraintsOfMapView() {
        mapView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(superviewInset)
        }
    }
    
    func setMapView(by cityData: CityData) {
        let location = CLLocationCoordinate2D(latitude: cityData.coord.lat, longitude: cityData.coord.lon)
        let span = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        let region = MKCoordinateRegion(center: location, span: span)
        let marker = Marker(cityName: cityData.name,
                            coordinate: location)
        mapView.addAnnotation(marker)
        mapView.setRegion(region, animated: true)
    }
    
}

// MARK: - Marker For MapView
class Marker: NSObject, MKAnnotation {
    
    let title: String?
    let coordinate: CLLocationCoordinate2D
    init(cityName: String, coordinate: CLLocationCoordinate2D) {
        self.title = cityName
        self.coordinate = coordinate
        super.init()
    }
    
}
