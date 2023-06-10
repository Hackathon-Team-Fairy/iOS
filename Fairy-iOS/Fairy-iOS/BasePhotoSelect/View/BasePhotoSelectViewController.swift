//
//  BasePhotoSelectViewController.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit

final class BasePhotoSelectViewConotroller: UIViewController {
    
    // MARK: - UI properties
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "temp5")
        return imageView
    }()
    
    private lazy var categoryCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCategoryCollectionViewLayout()
        )
        
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createPhotoCollectionViewLayout()
        )
        
        return collectionView
    }()
    
    // MARK: - Properties
    
    private var categoryDatasource: UICollectionViewDiffableDataSource<CategorySection, CategoryItem>?
    private var photoDatasource: UICollectionViewDiffableDataSource<PhotoSection, PhotoItem>?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        configureUI()
        registerCell()
        requestPhotoInfo()
        
    }
    
    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraint()
        configureDatasource()
        
    }
    
    private func configureSubviews() {
        [thumbnailImageView, categoryCollectionView, photoCollectionView].forEach {
            view.addSubview($0)
        }
    }
    
    private func configureConstraint() {
        thumbnailImageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
//            $0.top.equalToSuperview().offset(70)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(240)
            $0.width.equalTo(180)
        }
        categoryCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.top.equalTo(thumbnailImageView.snp.bottom).offset(40)
            $0.height.equalTo(35)
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

        group.edgeSpacing = .init(leading: nil, top: nil, trailing: .fixed(10), bottom: nil)
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func createPhotoCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/3),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
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
    }
    
    private func configureDatasource() {
        categoryDatasource = UICollectionViewDiffableDataSource<CategorySection, CategoryItem>(
            collectionView: categoryCollectionView,
            cellProvider: { collectionView, indexPath, item in
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasePhotoCategoryCell.identifier, for: indexPath) as? BasePhotoCategoryCell else { return UICollectionViewCell() }
                cell.configureUI(title: item)
                
                return cell
            })
    }
    
    // TODO: API로 카테고리랑 받아오면 처리
    
    private func requestPhotoInfo() {
        var categorySnapshot = NSDiffableDataSourceSnapshot<CategorySection, CategoryItem>()
        categorySnapshot.appendSections([.main])
        categorySnapshot.appendItems(["하하", "호호", "하하하하하", "하하하하"])
        
        categoryDatasource?.apply(categorySnapshot)
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
    
    typealias PhotoItem = String
}
