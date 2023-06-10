//
//  FairyListResponse.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import Foundation

struct FairyListResponse: Decodable, Hashable {
    let fairyTaleId: Int
    let fairyTaleTitle: String
    let fairyTaleCoverUrl: String
    let createdAt: String
}
