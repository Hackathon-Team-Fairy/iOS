//
//  FairyMakingSource.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/11.
//

import SwiftUI

class FairyMakingSource: ObservableObject{
    static let shared = FairyMakingSource()
    
    @Published var title: String = ""
    @Published var story1: String = ""
    @Published var story2: String = ""
    @Published var story3: String = ""
    @Published var story4: String = ""
    
    @Published var image: UIImage?
    @Published var imageURL: String?
    
    func clear(){
        self.title = ""
        self.story1 = ""
        self.story2 = ""
        self.story3 = ""
        self.story4 = ""
    }
}
