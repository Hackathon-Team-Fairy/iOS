//
//  TempViewController.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit

final class CreateFairyTaleViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        return view
    }()
    
    private let titleView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.distribution = .fill
        view.alignment = .fill
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(hexCode: "4DAC87")
        label.text = "동화 이야기를 만들어 볼까요?"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "* 질문에 답을하면 화면 이야기를 만들어드려요."
        label.font = .systemFont(ofSize: 15)
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
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let firstAnswerTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor(hexCode: "4DAC87").cgColor
        textView.backgroundColor = UIColor(hexCode: "F3F4EC")
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.contentInset = .init(top: 15, left: 10, bottom: 15, right: 10)
        textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
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
        label.text = "Q. 오늘 만났던 사람들 중 가장 인상 깊었던 사람은 누구였나요? 그 사람과의 만남은 어떤 경험을 가져다주었나요?"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let secondAnswerTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor(hexCode: "4DAC87").cgColor
        textView.backgroundColor = UIColor(hexCode: "F3F4EC")
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.contentInset = .init(top: 15, left: 10, bottom: 15, right: 10)
        textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
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
        label.text = "Q. 오늘 마주한 도전이나 어려움은 무엇이었나요?"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private let thirdAnswerTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.layer.borderColor = UIColor(hexCode: "4DAC87").cgColor
        textView.backgroundColor = UIColor(hexCode: "F3F4EC")
        textView.layer.borderWidth = 1
        textView.layer.cornerRadius = 20
        textView.contentInset = .init(top: 15, left: 10, bottom: 15, right: 10)
        textView.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return textView
    }()
    
    private let regenerateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexCode: "F3F4EC")
        button.layer.cornerRadius = 15
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 1
        button.setTitle("질문 다시 생성하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexCode: "4DAC87")
        button.layer.cornerRadius = 15
        button.setTitle("이야기 생성하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        return button
    }()
    
    private let bottomView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Function
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        
        firstAnswerTextView.delegate = self
        secondAnswerTextView.delegate = self
        thirdAnswerTextView.delegate = self
        
        configureSubviews()
        configureConstraint()
        addTargets()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(scrollViewTapped))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    private func configureSubviews() {
        [scrollView, createButton, bottomView].forEach { view.addSubview($0) }
        scrollView.addSubview(contentView)
        [titleView, firstStackView, secondStackView, thirdStackView, regenerateButton].forEach {
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
            $0.bottom.equalTo(createButton.snp.top).offset(-15)
            
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
            $0.top.equalTo(titleView.snp.bottom).offset(50)
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
//            $0.bottom.equalToSuperview().offset(-25)
        }
        
        thirdAnswerTextView.snp.makeConstraints {
            $0.height.greaterThanOrEqualTo(150)
        }
        
        regenerateButton.snp.makeConstraints { make in
            make.top.equalTo(thirdStackView.snp.bottom).offset(25)
            make.horizontalEdges.equalToSuperview().inset(100)
            make.height.equalTo(40)
            make.bottom.equalToSuperview().offset(-25)
        }
        
        createButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(25)
            $0.bottom.equalTo(bottomView.snp.top).offset(-50)
            $0.height.equalTo(50)
        }
        
        bottomView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(0)
        }
        
    }
    
    private func addTargets() {
        createButton.addTarget(self, action: #selector(createButtonTouchUpInside), for: .touchUpInside)
        regenerateButton.addTarget(self, action: #selector(regenerateButtonTouchUpInside), for: .touchUpInside)
    }
    
    @objc
    private func regenerateButtonTouchUpInside() {
        let regenerateAlertViewController = RegenerateAlertViewController()
        regenerateAlertViewController.modalPresentationStyle = .overFullScreen
        
        self.present(regenerateAlertViewController, animated: false)
        
    }
    
    @objc
    private func createButtonTouchUpInside() {
        let indicatorViewController = IndicatorViewController()
        indicatorViewController.indicatorStyle = IndicatorStyle.isGenerate
        indicatorViewController.qnaList = QnAList(contentList: [
            QnA(question: firstQuestTitleLabel.text ?? "", answer: firstAnswerTextView.text),
            QnA(question: secondQuestTitleLabel.text ?? "", answer: secondAnswerTextView.text),
            QnA(question: thirdQuestTitleLabel.text ?? "", answer: thirdAnswerTextView.text)
        ])
        navigationController?.pushViewController(indicatorViewController, animated: true)
    }
}

// MARK: Keyboard Noti

extension CreateFairyTaleViewController {
    @objc private func keyboardWillShow(_ notification: Notification) {
        // 키보드가 생성될 때
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            
            UIView.animate(withDuration: 0.5) {
                self.bottomView.snp.updateConstraints {
                    $0.height.equalTo(keyboardHeight - 35)
                }
                self.view.layoutIfNeeded()
            }
            
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.5) {
            self.bottomView.snp.updateConstraints {
                $0.height.equalTo(0)
            }
            self.view.layoutIfNeeded()
        }
        
    }
    
    @objc private func scrollViewTapped() {
        view.endEditing(true)
    }
}


extension CreateFairyTaleViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text == "" {
            textView.backgroundColor = UIColor(hexCode: "F3F4EC")
        } else {
            textView.backgroundColor = UIColor(hexCode: "4DAC87", alpha: 0.1)
        }
    }
}
