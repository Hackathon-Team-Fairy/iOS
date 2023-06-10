//
//  View+.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI

extension View{
    
    func endTextEditing(){
        UIApplication.shared.sendAction(
            #selector(UIResponder.resignFirstResponder),
            to:nil , from: nil, for: nil
        )
    }
    
}
