//
//  BasePhotoCategoryCell.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/11.
//

import UIKit

import SnapKit

final class BasePhotoCategoryCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.layer.borderColor = UIColor(hexCode: "B0B0B0", alpha: 1).cgColor
        stackView.layer.borderWidth = 1
        stackView.layer.cornerRadius = 12
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let leftEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let rightEmptyView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let categoryButton: UILabel = {
        let button = UILabel()
        button.layer.cornerRadius = 15
        button.font = .systemFont(ofSize: 16)
        return button
    }()
    
    // MARK: - Properties
    
    static let identifier = String(describing: BasePhotoCategoryCell.self)
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        addSubview(stackView)
        [leftEmptyView, categoryButton, rightEmptyView].forEach { stackView.addArrangedSubview($0) }
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        leftEmptyView.snp.makeConstraints {
            $0.width.equalTo(15)
        }
        rightEmptyView.snp.makeConstraints {
            $0.width.equalTo(15)
        }
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI(title: String) {
        categoryButton.text = title
    }
    
}
