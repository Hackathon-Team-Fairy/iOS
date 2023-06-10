//
//  FairytaleListViewController.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit

final class FairytaleListViewController: UIViewController {
    
    // MARK: - UI properties
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        return collectionView
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.layer.cornerRadius = 15
        button.setTitle("동화 생성하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18)
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let emptyButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 15
        button.tintColor = .black
        button.setTitle("등록한 동화가 없어요 😂", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: - Properties
    
    private var datasource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureUI()
        registerCell()
        requestFairytaleList()
    }

    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraint()
        configureDatasource()
        addTargets()
    }
    
    private func configureSubviews() {
        [stackView, createButton].forEach { view.addSubview($0) }
        [emptyButton, collectionView].forEach { stackView.addArrangedSubview($0)}
    }
    
    private func configureConstraint() {
        createButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-49)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(createButton.snp.top).offset(-30)
        }
        emptyButton.isHidden = true
    }
    
    private func registerCell() {
        collectionView.register(
            FairyListCollectionViewCell.self,
            forCellWithReuseIdentifier: FairyListCollectionViewCell.identifier
        )
    }
    
    private func addTargets() {
        createButton.addTarget(self, action: #selector(createButtonTouchUpInside), for: .touchUpInside)
    }
    
    private func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(1/2))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    private func configureDatasource() {
        datasource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FairyListCollectionViewCell.identifier, for: indexPath) as? FairyListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureUI(title: item)
            return cell
        })
    }
    
    // TODO: API 통신으로 코드 변경
    private func requestFairytaleList() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapShot.appendSections([.main])
        snapShot.appendItems(["책 이름 입니다1"], toSection: .main)
        snapShot.appendItems(["책 이름 입니다2"], toSection: .main)
        snapShot.appendItems(["책 이름 입니다3"], toSection: .main)
        snapShot.appendItems(["책 이름 입니다4"], toSection: .main)
        
        datasource?.apply(snapShot)
    }
    
    // MARK: Actions
    
    @objc
    private func createButtonTouchUpInside() {
        // TODO: 생성 버튼 눌릴시 이동
        print("동화 생성하기 버튼 탭")
    }
}


// MARK: UICollectionView Delegate

extension FairytaleListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = datasource?.itemIdentifier(for: indexPath) else { return }
        // TODO: 화면 이동
        print(item)
    }
}


// MARK: Enums

extension FairytaleListViewController {
    enum Section {
        case main
    }
    
    typealias Item = String
}
