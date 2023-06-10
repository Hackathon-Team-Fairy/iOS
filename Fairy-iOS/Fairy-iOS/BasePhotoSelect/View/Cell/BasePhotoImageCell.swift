//
//  BasePhotoImageCell.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/11.
//

import UIKit

import Kingfisher

final class BasePhotoImageCell: UICollectionViewCell {
    
    // MARK: - UI properties
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor(hexCode: "4DAC87", alpha: 1).cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Properties
    
    static let identifier = String(describing: BasePhotoImageCell.self)
    var didTapped: Bool = false
    
    // MARK: - Lifecycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 15
        addSubview(imageView)
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @available (*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    
    func configureUI(item: PhotoItem) {
        if let imageURL = URL(string: item.image) {
            imageView.kf.setImage(with: imageURL)
        }
        imageView.layer.borderWidth = item.isSelected ? 3 : 0
    }
    
    func didTappedCell() {
        didTapped.toggle()
    }
}
