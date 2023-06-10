//
//  EditStoryViewController.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import SwiftUI
import UIKit
import SnapKit

class EditStoryViewController: UIViewController {
    
    private let selectThumbNailButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        button.setTitle("표지선택하러가기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // SwiftUI 화면을 UIKit에 통합
        let contentView = EditStoryView()
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
        
        
        view.addSubview(selectThumbNailButton)
        selectThumbNailButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-49)
        }
        selectThumbNailButton.addTarget(self, action: #selector(selectButtonTouchUpInside), for: .touchUpInside)
        
        hostingController.didMove(toParent: self)
    }
    
    @objc
    private func selectButtonTouchUpInside() {
        let creatingFairyTaleViewController = PhotoSelectViewController()
        navigationController?.pushViewController(creatingFairyTaleViewController, animated: true)
    }
    
}