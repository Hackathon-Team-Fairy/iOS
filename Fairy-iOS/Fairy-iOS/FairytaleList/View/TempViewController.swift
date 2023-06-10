//
//  TempViewController.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit

final class TempViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        
        view.backgroundColor = .yellow
        
        return view
    }()
    
    private let titleView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "동화 이야기를 만들어 볼까요?"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "질문에 답을하면 화면"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let firstStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let firstQuestTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Q. 오늘 가장 특별하게 느꼈던 순간은 무엇이었나요?"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let firstAnswerTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let secondStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let secondQuestTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Q. 오늘 가장 특별하게 느꼈던 순간은 무엇이었나요?"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let secondAnswerTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let thirdStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let thirdQuestTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Q. 오늘 가장 특별하게 느꼈던 순간은 무엇이었나요?"
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let thirdAnswerTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        return textView
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        return button
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureSubviews()
        configureConstraint()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    private func configureSubviews() {
        [scrollView, createButton, bottomView].forEach { view.addSubview($0) }
        scrollView.addSubview(contentView)
        [titleView, firstStackView, secondStackView, thirdStackView].forEach {
            contentView.addSubview($0)
        }
        [titleLabel, descriptionLabel].forEach { titleView.addArrangedSubview($0) }
        [firstQuestTitleLabel, firstAnswerTextView].forEach { firstStackView.addArrangedSubview($0)}
        [secondQuestTitleLabel, secondAnswerTextView].forEach { secondStackView.addArrangedSubview($0)}
        [thirdQuestTitleLabel, thirdAnswerTextView].forEach { thirdStackView.addArrangedSubview($0)}
    }
    
    private func configureConstraint() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(createButton.snp.top).offset(-25)
            
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide.snp.width)
        }
        
        titleView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(25)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        firstStackView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        firstAnswerTextView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(150)
        }
        
        secondStackView.snp.makeConstraints {
            $0.top.equalTo(firstStackView.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(25)
        }
        
        secondAnswerTextView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(150)
        }
        
        thirdStackView.snp.makeConstraints {
            $0.top.equalTo(secondStackView.snp.bottom).offset(25)
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalToSuperview().offset(-25)
        }
        
        thirdAnswerTextView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(150)
        }
        
        createButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalTo(bottomView.snp.top).offset(-25)
            $0.height.equalTo(50)
        }
        
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(1)
        }
        
    }
}

// MARK: Keyboard Noti

extension TempViewController {
    @objc private func keyboardWillShow(_ notification: Notification) {
        // 키보드가 생성될 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            bottomView.snp.updateConstraints {
                $0.height.equalTo(keyboardHeight)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        bottomView.snp.updateConstraints {
            $0.height.equalTo(1)
        }
    }
    @objc private func scrollViewTapped() {
        view.endEditing(true)
    }
}
