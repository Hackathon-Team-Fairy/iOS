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
    
    var diary: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        
        
        print(diary)
        
        // SwiftUI 화면을 UIKit에 통합
        let contentView = EditStoryView(diary: diary!)
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
        
        
        view.addSubview(selectThumbNailButton)
        selectThumbNailButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-49)
        }
        selectThumbNailButton.addTarget(self, action: #selector(selectButtonTouchUpInside), for: .touchUpInside)
        
        hostingController.didMove(toParent: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.backAction = UIAction(handler: { action in
            guard let navigationStacks = self.navigationController?.viewControllers else { return }
            for viewController in navigationStacks {
                if let vc = viewController as? CreateFairyTaleViewController {
                    self.navigationController?.popToViewController(vc, animated: true)
                }
            }
        })
    }
    
    @objc
    private func selectButtonTouchUpInside() {
        let creatingFairyTaleViewController = PhotoSelectViewController()
        navigationController?.pushViewController(creatingFairyTaleViewController, animated: true)
    }
    
}
