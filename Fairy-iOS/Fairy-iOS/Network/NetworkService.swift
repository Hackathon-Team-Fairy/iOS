//
//  NetworkService.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import Foundation

final class NetworkService {
    static let shared: NetworkService = NetworkService()
    private init() { }
    
    let session = URLSession(configuration: .default)
    
    func load<T>(_ resource: Resource<T>, completionHandler: @escaping (Result<T, NetworkError>) -> Void) {
        guard let request = resource.urlRequest else {
            completionHandler(.failure(.invalidRequest))
            return
        }
        
        session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completionHandler(.failure(.invalidRequest))
                return
            }
            guard (200..<300) ~= response.statusCode else {
                completionHandler(.failure(.statusCodeError(statusCode: response.statusCode)))
                return
            }
            if let data, let decodeData = try? JSONDecoder().decode(T.self, from: data) {
                completionHandler(.success(decodeData))
            } else {
                completionHandler(.failure(.decodeError))
            }
        }.resume()
    
    }
}
