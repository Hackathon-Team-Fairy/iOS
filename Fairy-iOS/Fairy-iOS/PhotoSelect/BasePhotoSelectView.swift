//
//  BasePhotoSelectView.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/11.
//

import SwiftUI

struct BasePhotoSelectViewControllerWrapper: UIViewControllerRepresentable {
    typealias UIViewControllerType = BasePhotoSelectViewConotroller
    
    func makeUIViewController(context: Context) -> BasePhotoSelectViewConotroller {
        return BasePhotoSelectViewConotroller()
    }
    
    func updateUIViewController(_ uiViewController: BasePhotoSelectViewConotroller, context: Context) {
        // Optional: Implement this method if you need to update the view controller
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    final class Coordinator: NSObject {
        // Optional: Implement this class if you need to handle any delegate methods or events
    }
}
