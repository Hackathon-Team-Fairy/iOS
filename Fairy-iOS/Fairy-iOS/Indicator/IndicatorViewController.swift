//
//  IndicatorViewController.swift
//  Fairy-iOS
//
//  Created by 이정동 on 2023/06/11.
//

import UIKit
import Lottie
import SwiftKeychainWrapper

class IndicatorViewController: UIViewController {

    
    private var animationView: LottieAnimationView?
    
    var indicatorStyle: IndicatorStyle?
    var qnaList: QnAList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        
        configureAnimationView()
        
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
    
    private func configureAnimationView() {
        animationView = .init(name: "book")
        animationView!.frame = view.bounds
        animationView!.contentMode = .scaleAspectFit
        animationView!.loopMode = .loop
        animationView!.animationSpeed = 0.5
        view.addSubview(animationView!)
    }

    private func startAnimation() {
        animationView!.play()
        
        switch indicatorStyle {
        case .isGenerate:
            requestDiary()
        case .isComplete:
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
                print("완료")
                self.animationView!.stop()
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
                    self.animationView?.stop()
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


