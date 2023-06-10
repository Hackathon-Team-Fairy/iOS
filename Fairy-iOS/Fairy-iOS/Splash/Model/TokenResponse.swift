//
//  TokenResponse.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/11.
//

import Foundation

struct TokenResponse: Decodable {
    let accessToken: String
    let refreshToken: String
}
