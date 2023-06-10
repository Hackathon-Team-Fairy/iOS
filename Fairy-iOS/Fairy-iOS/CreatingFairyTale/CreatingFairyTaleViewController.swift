//
//  CreatingFairyTaleViewController.swift
//  Fairy-iOS
//
//  Created by 이정동 on 2023/06/10.
//

import UIKit
import SnapKit

final class CreatingFairyTaleViewController: UIViewController {
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let topViewFirstLabel: UILabel = {
        let label = UILabel()
        label.text = "동화 이야기를 만들어 볼까요?"
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    let topViewSecondLabel: UILabel = {
        let label = UILabel()
        label.text = "* 질문에 답을 하면 이야기를 만들어드려요."
        label.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    
    let firstQuestionView: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    
    
    let secondQuestionView: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        return view
    }()
    
    let thirdQuestionView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        button.setTitle("동화 생성하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.tintColor = .black
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        configureUIView()
    }
    
    private func configureUIView() {
        configureSubViews()
        configureConstraint()
    }
    
    private func configureSubViews() {
        view.addSubview(scrollView) // 메인뷰에
        view.addSubview(createButton)
        
        scrollView.addSubview(topView)
        scrollView.addSubview(contentView)
        
        _ = [topViewFirstLabel, topViewSecondLabel].map { self.topView.addSubview($0) }
        
        _ = [firstQuestionView, secondQuestionView, thirdQuestionView].map { self.contentView.addSubview($0)}
    }
    
    private func configureConstraint() {
        scrollView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(createButton.snp.top).offset(-30)
        }
        
        topView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview().inset(25)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(30)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.top.equalTo(topView.snp.bottom).offset(50)
            make.centerX.bottom.equalToSuperview()
        }
        
        topViewFirstLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        topViewSecondLabel.snp.makeConstraints { make in
            make.top.equalTo(topViewFirstLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        firstQuestionView.snp.makeConstraints { (make) in
            
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        secondQuestionView.snp.makeConstraints { (make) in
            
            make.top.equalTo(firstQuestionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        thirdQuestionView.snp.makeConstraints { (make) in
            
            make.top.equalTo(secondQuestionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
            make.bottom.equalToSuperview() // 이것이 중요함
        }
        
        createButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().offset(-49)
        }
    }
    
}
