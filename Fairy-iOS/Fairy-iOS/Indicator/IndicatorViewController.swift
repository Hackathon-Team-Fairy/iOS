//
//  IndicatorViewController.swift
//  Fairy-iOS
//
//  Created by 이정동 on 2023/06/11.
//

import UIKit
import Lottie
import SnapKit
import SwiftKeychainWrapper

class IndicatorViewController: UIViewController {
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()
    
    private var animationView: LottieAnimationView = {
        let view = LottieAnimationView(name: "book")
        view.contentMode = .scaleAspectFit
        view.loopMode = .loop
        view.animationSpeed = 0.5
        return view
    }()
    
    var indicatorStyle: IndicatorStyle?
    var qnaList: QnAList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        
        messageLabel.text = indicatorStyle?.rawValue
        
        configureUIView()
        
        startAnimation()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.setHidesBackButton(true, animated: true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationItem.setHidesBackButton(false, animated: true)
    }
    
    
    private func configureUIView() {
        configureAddSubviews()
        configureConstraint()
    }
    
    private func configureAddSubviews() {
        view.addSubview(animationView)
        view.addSubview(messageLabel)
    }
    
    
    private func configureConstraint() {
        animationView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.top.equalTo(animationView.snp.bottom).offset(30)
            make.height.equalTo(40)
            make.centerX.equalToSuperview()
        }
    }
    
    private func startAnimation() {
        animationView.play()
        
        switch indicatorStyle {
        case .isGenerate:
            requestDiary()
        case .isComplete:
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                print("완료")
                self.animationView.stop()
            }
        case .none:
            print("return")
            return
        }
    }
    
    private func requestDiary() {
        guard let jwt = KeychainWrapper.standard.string(forKey: Utils.ACCESS_TOEKN) else { print("Token err"); return }
        
        guard let qnaList = qnaList else { print("qnalist err"); return }
        
        guard let data = try? JSONEncoder().encode(qnaList) else { print("encode err"); return }
        
        let resource = Resource<[String]>(
            base: Utils.BASE_URL + "init/diary",
            method: .POST,
            paramaters: [:],
            header: ["Authorization":"Bearer \(jwt)"],
            body: data
        )
        NetworkService.shared.load(resource) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    self.animationView.stop()
                    //print(response)
                    let editStoryViewController = EditStoryViewController()
                    editStoryViewController.diary = response
                    self.navigationController?.pushViewController(editStoryViewController, animated: true)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}


