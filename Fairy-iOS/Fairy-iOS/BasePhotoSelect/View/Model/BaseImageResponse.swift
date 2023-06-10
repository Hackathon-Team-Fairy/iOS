//
//  BaseImageResponse.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/11.
//

import Foundation

struct BaseImageResponse: Decodable, Hashable {
    let type: String
    let imagesList: [String]
}
