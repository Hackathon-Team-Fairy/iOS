//
//  BasePhotoSelectViewController.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper
import Kingfisher

final class BasePhotoSelectViewConotroller: UIViewController {
    
    // MARK: - UI properties
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor(hexCode: "4DAC87", alpha: 1).cgColor
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCategoryCollectionViewLayout()
        )
        
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createPhotoCollectionViewLayout()
        )
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        
        return collectionView
    }()
    
    private let selectButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.setTitle("선택하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Properties
    
    private var imageDict: [String: [PhotoItem]] = [:]
    
    private var categoryDatasource: UICollectionViewDiffableDataSource<CategorySection, CategoryItem>?
    private var photoDatasource: UICollectionViewDiffableDataSource<PhotoSection, PhotoItem>?
    private var photoSnapshot: NSDiffableDataSourceSnapshot<PhotoSection, PhotoItem>?
    private var selectedCategory: String?
    private var selectedImageURL: String?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        configureUI()
        registerCell()
        requestPhotoInfo()
        addTargets()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraint()
        configureDatasource()
        
    }
    
    private func configureSubviews() {
        [thumbnailImageView, categoryCollectionView, photoCollectionView, selectButton].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraint() {
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(240)
            $0.width.equalTo(180)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(40)
            $0.height.equalTo(35)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(categoryCollectionView.snp.bottom).offset(15)
            $0.bottom.equalTo(selectButton.snp.top).offset(-10)
        }
        
        selectButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
    
    private func createCategoryCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .estimated(100),
                                               heightDimension: .fractionalHeight(1))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])

        group.edgeSpacing = .init(leading: nil, top: nil, trailing: .fixed(5), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createPhotoCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 5, leading: 10, bottom: 5, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/2))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func registerCell() {
        categoryCollectionView.register(
            BasePhotoCategoryCell.self,
            forCellWithReuseIdentifier: BasePhotoCategoryCell.identifier
        )
        photoCollectionView.register(
            BasePhotoImageCell.self,
            forCellWithReuseIdentifier: BasePhotoImageCell.identifier
        )
    }
    
    private func configureDatasource() {
        categoryDatasource = UICollectionViewDiffableDataSource<CategorySection, CategoryItem>(
            collectionView: categoryCollectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasePhotoCategoryCell.identifier, for: indexPath) as? BasePhotoCategoryCell else { return UICollectionViewCell() }
                cell.configureUI(title: item)
                
                return cell
            })
        photoDatasource = UICollectionViewDiffableDataSource<PhotoSection, PhotoItem>(
            collectionView: photoCollectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: BasePhotoImageCell.identifier,
                    for: indexPath
                ) as? BasePhotoImageCell else { return UICollectionViewCell() }
                
                cell.configureUI(item: item)
                return cell
            })
    }
    
    // TODO: API로 카테고리랑 받아오면 처리
    
    private func requestPhotoInfo() {
        let resource = Resource<[BaseImageResponse]>(
            base: Utils.BASE_URL + "images",
            method: .GET,
            paramaters: [:],
            header: ["Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: Utils.ACCESS_TOEKN) ?? "")" ]
        )
        
        NetworkService.shared.load(resource) { response in
            switch response {
            case .success(let response):
                response.forEach { self.imageDict[$0.type] = $0.imagesList.map { PhotoItem(image: $0) }  }
                var categorySnapshot = NSDiffableDataSourceSnapshot<CategorySection, CategoryItem>()
                categorySnapshot.appendSections([.main])
                categorySnapshot.appendItems(self.imageDict.keys.map { String($0) }.sorted())
                self.categoryDatasource?.apply(categorySnapshot)
                
                let firstCategory = self.imageDict.keys.map { String($0) }.sorted().first!
                
                self.photoSnapshot = NSDiffableDataSourceSnapshot<PhotoSection, PhotoItem>()
                self.photoSnapshot?.appendSections([.main])
                self.photoSnapshot?.appendItems(self.imageDict[firstCategory, default: []], toSection: .main)

                
                if let photoSnapshot = self.photoSnapshot {
                    self.photoDatasource?.apply(photoSnapshot)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func addTargets() {
        selectButton.addTarget(self, action: #selector(selectButtonTouchUpInside), for: .touchUpInside)
    }
    
    @objc
    private func selectButtonTouchUpInside() {
        if let selectedImageURL {
            FairyMakingSource.shared.image = nil
            FairyMakingSource.shared.imageURL = selectedImageURL
            dismiss(animated: true)
        } else {
            print("이미지 없음")
        }
    }
}

extension BasePhotoSelectViewConotroller: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == categoryCollectionView,
           let item = categoryDatasource?.itemIdentifier(for: indexPath) {
            self.photoSnapshot = NSDiffableDataSourceSnapshot<PhotoSection, PhotoItem>()
            self.photoSnapshot?.appendSections([.main])
            self.photoSnapshot?.appendItems(imageDict[item, default: []], toSection: .main)
            selectedCategory = item
            
            if let photoSnapshot {
                photoDatasource?.apply(photoSnapshot)
            }
        }
        
        if collectionView == photoCollectionView,
           let item = photoDatasource?.itemIdentifier(for: indexPath),
           let url = URL(string: item.image) {
            selectButton.backgroundColor = UIColor(hexCode: "4DAC87", alpha: 1)
            selectButton.isEnabled = true
            thumbnailImageView.kf.setImage(with: url)
            selectedImageURL = item.image
        }
        
    }
}

// MARK: Enums

extension BasePhotoSelectViewConotroller {
    enum CategorySection {
        case main
    }
    
    typealias CategoryItem = String
    
    enum PhotoSection {
        case main
    }
    
//    typealias PhotoItem = String
    
   
}

struct PhotoItem: Hashable {
    let image: String
    var isSelected: Bool = false
}
