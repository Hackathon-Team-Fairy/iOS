//
//  PhotoSelectViewController.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import UIKit
import SwiftUI

class PhotoSelectViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SwiftUI 화면을 UIKit에 통합
        let contentView = PhotoSelectView()
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
}
