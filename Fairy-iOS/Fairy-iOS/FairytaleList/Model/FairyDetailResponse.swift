//
//  FairyDetailResponse.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/11.
//

import Foundation

struct FairyDetailResponse: Decodable {
    let fairyTaleId: Int
    let fairyTaleTitle: String
    let fairyTaleCoverUrl: String
    let fairyTaleContent: [String]
}
