//
//  ReadingStoryViewController.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/11.
//

import SwiftUI
import UIKit
import SnapKit

class ReadingStoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        
        // SwiftUI 화면을 UIKit에 통합
        let contentView = ReadingStoryView()
        let hostingController = UIHostingController(rootView: contentView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
    
    @objc
    private func selectButtonTouchUpInside() {
        let creatingFairyTaleViewController = PhotoSelectViewController()
        navigationController?.pushViewController(creatingFairyTaleViewController, animated: true)
    }
    
}
