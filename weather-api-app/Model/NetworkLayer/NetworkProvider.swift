//
//  NetworkProvider.swift
//  weather-api-app
//
//  Created by Apple on 2023/01/17.
//

import Foundation

struct NetworkProvider<Target: TargetType> {
    
    func request(_ target: Target) throws -> URLRequest {
        let path = target.baseURL + target.path
        guard var urlComponents = URLComponents(string: path) else {
            throw NetworkError.invalidURLComponents(path)
        }
        var url: URL?
        let task = target.task
        switch task {
        case .requestPlain:
            url = urlComponents.url
        case .requestParameters(let parameters, let encoding):
            switch encoding {
            case .queryString:
                let queryItemArray = parameters.map {
                    URLQueryItem(name: $0.key, value: $0.value as? String)
                }
                urlComponents.queryItems = queryItemArray
                url = urlComponents.url
            }
        }
        guard let url = url else {
            throw NetworkError.invalidURLString
        }
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        if let headerField = target.headers {
            _ = headerField.map { (key, value) in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
}
