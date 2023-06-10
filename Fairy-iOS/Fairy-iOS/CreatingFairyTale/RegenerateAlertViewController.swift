//
//  RegenerateAlertViewController.swift
//  Fairy-iOS
//
//  Created by 이정동 on 2023/06/10.
//

import UIKit
import SnapKit

class RegenerateAlertViewController: UIViewController {
    
    // MARK: - UI Property
    private let alertView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let alertTitle: UILabel = {
        let label = UILabel()
        label.text = "질문 다시 생성하기"
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let alertMessage: UILabel = {
        let label = UILabel()
        label.text = "질문을 다시 생성하시면\n기존의 답변들은 삭제됩니다."
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.spacing = 35
        return stackView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(hexCode: "D9D9D9")
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("생성하기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.backgroundColor = UIColor(hexCode: "D9D9D9")
        button.layer.cornerRadius = 15
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.layer.backgroundColor = UIColor.black.cgColor.copy(alpha: 0.5)
        configureUIView()
    }
    
    private func configureUIView() {
        configureSubViews()
        configureConstraint()
        addTargets()
    }
    
    private func configureSubViews() {
        view.addSubview(alertView)
        alertView.addSubview(alertTitle)
        alertView.addSubview(alertMessage)
        alertView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(createButton)
    }
    
    private func configureConstraint() {
        alertView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(300)
            make.height.equalTo(200)
        }
        
        alertTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(30)
            make.centerX.equalToSuperview()
        }
        
        alertMessage.snp.makeConstraints { make in
            make.top.equalTo(alertTitle.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(alertMessage.snp.bottom).offset(35)
            make.horizontalEdges.bottom.equalToSuperview().inset(30)
        }
    }
    
    private func addTargets() {
        cancelButton.addTarget(self, action: #selector(cancelButtonTouchUpInside), for: .touchUpInside)
        createButton.addTarget(self, action: #selector(createButtonTouchUpInside), for: .touchUpInside)
    }

    @objc
    private func cancelButtonTouchUpInside() {
        dismiss(animated: false)
    }

    @objc
    private func createButtonTouchUpInside() {
        
    }
}


extension UIColor {
    
    convenience init(hexCode: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hexCode.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased()
        
        if hexFormatted.hasPrefix("#") {
            hexFormatted = String(hexFormatted.dropFirst())
        }
        
        assert(hexFormatted.count == 6, "Invalid hex code used.")
        
        var rgbValue: UInt64 = 0
        Scanner(string: hexFormatted).scanHexInt64(&rgbValue)
        
        self.init(red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
                  green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
                  blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
                  alpha: alpha)
    }
}
