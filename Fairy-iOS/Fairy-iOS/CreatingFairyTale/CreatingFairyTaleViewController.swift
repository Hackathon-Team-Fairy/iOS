//
//  CreatingFairyTaleViewController.swift
//  Fairy-iOS
//
//  Created by 이정동 on 2023/06/10.
//

import UIKit
import SnapKit

final class CreatingFairyTaleViewController: UIViewController {
    
    // MARK: - UI Property
    
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
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return label
    }()
    
    
    let firstQuestionView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 가장 특별하게 느꼈던 순간은 무엇이었나요?"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let firstTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textView
    }()
    
    let secondQuestionView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 가장 특별하게 느꼈던 순간은 무엇이었나요?"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let secondTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textView
    }()
    
    let thirdQuestionView: UIView = {
        let view = UIView()

        return view
    }()
    
    let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 가장 특별하게 느꼈던 순간은 무엇이었나요?"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    let thirdTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textView
    }()
    
    private let regenerativeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 1
        button.setTitle("질문 다시 생성하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.lightGray, for: .normal)
        return button
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
    
    // MARK: - viewDidLoad
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
        scrollView.addSubview(regenerativeButton)
        
        firstQuestionView.addSubview(firstLabel)
        firstQuestionView.addSubview(firstTextView)

        secondQuestionView.addSubview(secondLabel)
        secondQuestionView.addSubview(secondTextView)

        thirdQuestionView.addSubview(thirdLabel)
        thirdQuestionView.addSubview(thirdTextView)
        
        
        let _ = [topViewFirstLabel, topViewSecondLabel].map { self.topView.addSubview($0) }
        
        let _ = [firstQuestionView, secondQuestionView, thirdQuestionView].map { self.contentView.addSubview($0)}
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
            
            make.top.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(300)
        }
        
        firstLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        firstTextView.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        secondQuestionView.snp.makeConstraints { (make) in
            
            make.top.equalTo(firstQuestionView.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(300)
        }
        
        secondLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        secondTextView.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        thirdQuestionView.snp.makeConstraints { (make) in
            
            make.top.equalTo(secondQuestionView.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(25)
            make.height.equalTo(300)
            //make.bottom.equalToSuperview() // 이것이 중요함
        }
        
        thirdLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        
        thirdTextView.snp.makeConstraints { make in
            make.top.equalTo(thirdLabel.snp.bottom).offset(20)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        
        regenerativeButton.snp.makeConstraints { make in
            make.top.equalTo(thirdQuestionView.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(100)
            make.height.equalTo(40)
            make.bottom.equalToSuperview()
        }
        
        createButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(28)
            make.bottom.equalToSuperview().offset(-49)
        }
    }
    
}
