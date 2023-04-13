//
//  Constants.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation
import Alamofire

struct Constants {
    
    struct Network {
        static let appid = "a50685674910fa58b68f60c8d0d7835a"
        static let citylistFileName = "citylist"
    }
    
    struct Model {
        static let defaultCityData = CityData(id: 1839726, name: "Asan", country: "KR", coord: Coord(lat: 36.783611, lon: 127.004173))
    }
    
    struct Image {
        static let clear = UIImage(named: "01d") ?? UIImage()
        static let clouds = UIImage(named: "04d") ?? UIImage()
        static let rain = UIImage(named: "09d") ?? UIImage()
        static let snow = UIImage(named: "13d") ?? UIImage()
    }
    
    struct FontName {
        static let appleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
        static let appleSDGothicNeoSemiBold = "AppleSDGothicNeo-SemiBold"
        static let appleSDGothicNeoRegular = "AppleSDGothicNeo-Regular"
    }
    
    struct Color {
        static let mainBackground = UIColor(red: 108.0/255.0, green: 147.0/255.0, blue: 194.0/255.0, alpha: 1.0)
        static let mainSection = UIColor(red: 78.0/255.0, green: 126.0/255.0, blue: 186.0/255.0, alpha: 1.0)
        static let searchBar = UIColor(red: 152.0/255.0, green: 180.0/255.0, blue: 213.0/255.0, alpha: 1.0)
    }
    
    struct MainViewController {
        static let elementOffset: CGFloat = 10.0
        static let secondSectionViewHeight = SecondSectionView.collectionViewHeight + SecondSectionView.superviewInset * 2
        static let thirdSectionViewHeight = FiveDaysForecastTableViewCell.weatherImageViewSide * 5 + FiveDaysForecastTableViewCell.superviewInset * 2
    }
    
    struct SecondSectionView {
        static let superviewInset: CGFloat = 10.0
        static let collectionViewHeight: CGFloat = ThreeHoursForecastCollectionViewCell.cellSize.height
    }
    
    struct ThreeHoursForecastCollectionViewCell {
        static let superviewInset: CGFloat = 10.0
        static let elementOffset: CGFloat = 5.0
        static let labelWidth: CGFloat = 70.0
        static let labelHeight: CGFloat = 20.0
        static let weatherImageViewSide: CGFloat = 50.0
        static let cellSize: CGSize = CGSize(width: labelWidth + superviewInset * 2, height: labelHeight * 2 + weatherImageViewSide + superviewInset * 2 + elementOffset * 2)
    }
    
    struct ThirdSectionView {
        static let superviewInset: CGFloat = 10.0
    }
    
    struct FiveDaysForecastTableViewCell {
        static let superviewInset: CGFloat = 10.0
        static let weatherImageViewSide: CGFloat = 38.0
        static let elementOffset: CGFloat = 100.0
        static let cellHeight: CGFloat = weatherImageViewSide + superviewInset * 2
    }
    
    struct FourthSectionView {
        static let superviewInset: CGFloat = 10.0
    }
    
    struct FifthSectionView {
        static let superviewInset: CGFloat = 10.0
        static let elementOffset: CGFloat = 10.0
    }
    
}
