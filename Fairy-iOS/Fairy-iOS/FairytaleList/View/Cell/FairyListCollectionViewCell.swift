//
//  FairyListCollectionViewCell.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit
import Kingfisher

final class FairyListCollectionViewCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let coverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "EDF1D6", alpha: 1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let createDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .light)
        label.textColor = UIColor(hexCode: "828282", alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    private let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.clipsToBounds = true
        return stackView
    }()
    
    // MARK: - Properties
    
    static let identifier = String(describing: FairyListCollectionViewCell.self)
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews()
        configureConstraint()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    private func configureSubviews() {
        [coverView, labelStackView].forEach { addSubview($0) }
        coverView.addSubview(thumbnailImageView)
        [nameLabel, createDateLabel].forEach { labelStackView.addArrangedSubview($0) }
    }
    
    private func configureConstraint() {
        labelStackView.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.horizontalEdges.equalToSuperview()
            $0.height.equalTo(50)
        }
        
        coverView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(labelStackView.snp.top).offset(-15)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(12)
        }
    }
    
    func configureUI(item: FairyListResponse) {
        nameLabel.text = item.fairyTaleTitle
        createDateLabel.text = item.createdAt
        if let url = URL(string: item.fairyTaleCoverUrl) {
            thumbnailImageView.kf.setImage(with: url)
        }
    }
    
}
