//
//  Resource.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import Foundation

struct Resource<T: Decodable> {
    let base: String
    let method: HttpMethod
    let paramaters: [String: String]
    let header: [String: String]
    
    var urlRequest: URLRequest? {
        guard var urlComponents = URLComponents(string: base) else { return nil }
        let queryItems = paramaters.map { key, value in
            URLQueryItem(name: key, value: value)
        }
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if method == .POST,  let jsonData = try? JSONEncoder().encode(paramaters) {
            request.httpBody = jsonData
        }
        
        header.forEach { key, value in
            request.addValue(value, forHTTPHeaderField: key)
        }

        return request
    }
}
