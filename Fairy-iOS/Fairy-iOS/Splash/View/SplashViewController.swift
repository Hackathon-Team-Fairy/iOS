//
//  SplashViewController.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper

final class SplashViewController: UIViewController {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: ImageNameSpace.splashImage.rawValue)
        imageView.alpha = 0
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "4DAC87")
        view.addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        requestJWT()
        
        startAnimation()
    }
    
    private func startAnimation() {
        UIView.animate(withDuration: 2.0, delay: 1.5, options: .curveEaseOut, animations: {
            self.imageView.alpha = 1
        }, completion: { _ in
            let navigaionViewController = UINavigationController(rootViewController: FairytaleListViewController())
            self.changeRootViewController(navigaionViewController)
        })
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
    
    private func requestJWT() {
        
        let resource = Resource<TokenResponse>(
            base: Utils.BASE_URL + "fairy/device",
            method: .POST,
            paramaters: ["deviceName": Utils.getDeviceUUID()],
            header: [:]
        )
        NetworkService.shared.load(resource) { result in
            switch result {
            case .success(let response):
                KeychainWrapper.standard.set(response.accessToken, forKey: Utils.ACCESS_TOEKN)
                print(response)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
}
