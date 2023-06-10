//
//  ReadingStoryViewController.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/11.
//

import SwiftUI
import UIKit
import SnapKit
import SwiftKeychainWrapper

class ReadingStoryViewController: UIViewController {
    
    let id: Int
    
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        detailRequest()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func uiKitConvertToSwiftUI(
        title: String,
        imageURL: String,
        story1: String,
        story2: String,
        story3: String,
        story4: String
    ) {
        let contentView = ReadingStoryView(
            title: title,
            imageURL: imageURL,
            story1: story1,
            story2: story2,
            story3: story3,
            story4: story4
        )
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

extension ReadingStoryViewController {
    private func detailRequest() {
    
        let resource = Resource<FairyDetailResponse>(
            base: Utils.BASE_URL + "diary/\(id)",
            method: .GET,
            paramaters: [:],
            header: ["Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: Utils.ACCESS_TOEKN) ?? "")" ]
        )
        NetworkService.shared.load(resource) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.uiKitConvertToSwiftUI(
                        title: response.fairyTaleTitle,
                        imageURL: response.fairyTaleCoverUrl,
                        story1: response.fairyTaleContent[0],
                        story2: response.fairyTaleContent[1],
                        story3: response.fairyTaleContent[2],
                        story4: response.fairyTaleContent[3])
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
