# 세계 날씨 앱 토이 프로젝트
- [OpenWeatherAPI](https://api.openweathermap.org)를 이용한 앱입니다.  
세계 각 지역의 시간 별, 날짜 별 기온을 알 수 있고 습도, 구름, 풍속, 기압 등의 정보를 제공합니다.  
검색을 통해 도시를 선택할 수 있고, 지도에서 해당 도시의 위치를 표시해 줍니다.
- 프로젝트 기간 : 23.1.16 ~ 23.1.19
- *커밋 이력은 Private 저장소에 따로 기록되어 있습니다.*

## 개발 환경
- IDE : Xcode 13.4.1
- 언어 : Swift 5.6.1
- Deployment Target : iOS 13.0
- 써드파티 라이브러리 관리 : CocoaPods

## 기술
- 라이브러리
    - Reusable
    - RxSwift, RxCocoa
    - SnapKit
    - SwiftLint
- 아키텍처
    - MVVM

## 실행 방법
- ```pod install```이 필요합니다.

## 사용 예시
![](https://user-images.githubusercontent.com/60916423/231767697-46d4bec5-055f-4579-a564-c18d1935cd17.gif)
![](https://user-images.githubusercontent.com/60916423/231767714-59b6c9af-8b66-4e38-930e-5a730469361f.gif)

## 프로젝트 구조
- 모식도  
![](https://user-images.githubusercontent.com/60916423/213357389-6d18bfa9-ace9-488e-9ad0-d4329eae5693.png)  
    - 화살표는 의존 관계를 나타냅니다.
- 프로젝트에서는 MVVM 아키텍처를 적용하였으며, 크게 Model 디렉토리와 View 디렉토리로 나뉩니다.
- Model 디렉토리는 Model과 Manager로 나뉩니다.
    - Model에는 API Response 데이터나 로컬 JSON File 데이터를 받을 수 있도록 데이터 모델이 정의되어 있습니다.
    - Manager에는 Network API을 사용할 수 있는 NetworkManager와 로컬 JSON File을 가져올 수 있는 LocalResourceManager가 있습니다.  
    이 2가지 Manager를 인스턴스로 가져 모든 종류의 데이터에 접근할 수 있는 DataManager가 있습니다.  
    따라서 Model 외부에서는 DataManager만을 사용하여 데이터에 접근하게 됩니다.
    - NetworkManager를 구성하는 NetworkLayer가 있습니다.  
    NetworkLayer는 NetworkProvider, NetworkService, TargetType ... 등으로 구성되어 있습니다.  
    Moya의 구조를 참고하여 구현하였습니다.
- View 디렉토리는 화면에 따라 Main과 Search로 나뉩니다.
    - 각각의 화면은 ViewController와 ViewModel을 가집니다.  
    ViewController에서는 UI를 구현하기 위한 코드를 가집니다.  
    ViewModel에서는 데이터 바인딩을 위해 Model에서 데이터를 받아와 로직을 거친 뒤 RxSwift를 통해 ViewController로 데이터 스트림을 방출합니다.  
    - ViewController는 여러 Custom View들에 의해 구현됩니다.  
    예를 들어 MainViewController에서는 화면을 크게 5가지 영역으로 구분하여 FirstSectionView, SecondSectionView, ... , FifthSectionView으로 구성하고 있습니다.
