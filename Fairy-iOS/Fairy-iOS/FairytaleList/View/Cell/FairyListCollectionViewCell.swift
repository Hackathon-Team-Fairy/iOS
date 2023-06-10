//
//  FairyListCollectionViewCell.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit

final class FairyListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.tintColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let createDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.tintColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    // MARK: - Properties
    
    static let identifier = String(describing: FairyListCollectionViewCell.self)
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureConstraint()
        layer.cornerRadius = 12
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 1
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureSubviews() {
        [thumbnailImageView, labelStackView].forEach { addSubview($0) }
        [nameLabel, createDateLabel].forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func configureConstraint() {
        labelStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(labelStackView.snp.top).inset(30)
        }
    }
    
    func configureUI(title: String) {
        nameLabel.text = title
        createDateLabel.text = "2023-06-10"
        thumbnailImageView.image = UIImage(systemName: "heart.fill")
    }
    
}
