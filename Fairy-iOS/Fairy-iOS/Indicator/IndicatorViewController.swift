//
//  IndicatorViewController.swift
//  Fairy-iOS
//
//  Created by 이정동 on 2023/06/11.
//

import UIKit
import Lottie

class IndicatorViewController: UIViewController {

    
    private var animationView: LottieAnimationView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 2. Start AnimationView with animation name (without extension)
        view.backgroundColor = UIColor(hexCode: "4DAC87")
        
        animationView = .init(name: "book")
        
        animationView!.frame = view.bounds
        
        // 3. Set animation content mode
        
        animationView!.contentMode = .scaleAspectFit
        
        // 4. Set animation loop mode
        
        animationView!.loopMode = .loop
        
        // 5. Adjust animation speed
        
        animationView!.animationSpeed = 0.5
        
        view.addSubview(animationView!)
        
        // 6. Play animation
        
        animationView!.play()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.animationView!.stop()
            let editStoryViewController = EditStoryViewController()
            self.navigationController?.pushViewController(editStoryViewController, animated: true)
        }
        
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

}
