//
//  PhotoSelectViewController.swift
//  Fairy-iOS
//
//  Created by Eric Lee on 2023/06/10.
//

import UIKit
import SwiftUI
import SnapKit
import SwiftKeychainWrapper

class PhotoSelectViewController: UIViewController {
    private let completeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexCode: "4DAC87", alpha: 1)
        button.layer.cornerRadius = 15
        button.setTitle("완성하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        
        return button
    }()
    
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
        view.addSubview(completeButton)
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-49)
        }
        completeButton.addTarget(self, action: #selector(selectButtonTouchUpInside), for: .touchUpInside)
        
        hostingController.didMove(toParent: self)
    }
    
    @objc
    private func selectButtonTouchUpInside() {
        let fairyMakingSource = FairyMakingSource.shared
        let request = DiaryResponse(title: fairyMakingSource.title, content: [fairyMakingSource.story1, fairyMakingSource.story2, fairyMakingSource.story3, fairyMakingSource.story4], coverUrl: fairyMakingSource.imageURL ?? "")
        
        if let jsonData = try? JSONEncoder().encode(request) {
            let resource = Resource<DiaryResponse>(
                base: Utils.BASE_URL + "diary",
                method: .POST,
                paramaters: [:],
                header:  ["Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: Utils.ACCESS_TOEKN) ?? "")" ],
                body: jsonData)
            
            NetworkService.shared.load(resource) { response in
                switch response {
                case .success(let response):
                    print(response)
                    DispatchQueue.main.async {
                        let navigaionViewController = UINavigationController(rootViewController: FairytaleListViewController())
                        self.changeRootViewController(navigaionViewController)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
        
    }
    
    private func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
}

struct DiaryResponse: Codable {
    let title: String
    let content: [String]
    let coverUrl: String
}


