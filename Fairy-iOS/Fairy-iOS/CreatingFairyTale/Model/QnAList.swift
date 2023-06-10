//
//  QnAListRequest.swift
//  Fairy-iOS
//
//  Created by 이정동 on 2023/06/11.
//

import Foundation
import UIKit

struct QnAList: Encodable {
    var contentList: [QnA]
}

struct QnA: Encodable {
    var question: String
    var answer: String
}
