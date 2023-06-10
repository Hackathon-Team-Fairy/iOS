//
//  NetworkError.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case statusCodeError(statusCode: Int)
    case decodeError
}
