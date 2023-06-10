//
//  Utils.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/11.
//

import UIKit

struct Utils {
    static let BASE_URL = "https://www.deboost.shop/"
    static let ACCESS_TOEKN = "ACCESS_TOKEN"
    
    
    static func getDeviceUUID() -> String {
        return UIDevice.current.identifierForVendor!.uuidString
    }
}
