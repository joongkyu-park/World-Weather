# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'weather-api-app' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire'
  pod 'Reusable'
  pod 'RxCocoa', '6.5.0'
  pod 'RxSwift', '6.5.0'
  pod 'SnapKit', '~> 5.6.0'
  pod 'SwiftLint'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
    end
end
