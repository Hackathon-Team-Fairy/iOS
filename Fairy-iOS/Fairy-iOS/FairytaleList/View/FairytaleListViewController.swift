//
//  FairytaleListViewController.swift
//  Fairy-iOS
//
//  Created by 김민석 on 2023/06/10.
//

import UIKit

import SnapKit
import SwiftKeychainWrapper

final class FairytaleListViewController: UIViewController {
    
    // MARK: - UI properties
    
    private lazy var collectionView: UICollectionView = {
        let collectionView: UICollectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createCollectionViewLayout())
        collectionView.backgroundColor = UIColor(hexCode: "F3F4EC")
        collectionView.delegate = self
        return collectionView
    }()
    
    private let createButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexCode: "4DAC87", alpha: 1)
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
    
    private let emptyView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        return view
    }()
    
    private let emptyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: ImageNameSpace.emptyImage.rawValue)
        
        return imageView
    }()
    
    private let emptyLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "아직 만들어진 동화가 없어요"
        return label
    }()
   
    // MARK: - Properties
    
    private var datasource: UICollectionViewDiffableDataSource<Section, Item>?
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexCode: "F3F4EC")
        configureUI()
        registerCell()
        requestDiary()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.largeTitleDisplayMode = .always
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        //navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - Helpers
    
    private func configureUI() {
        configureSubviews()
        configureConstraint()
        configureNavigation()
        configureDatasource()
        addTargets()
    }
    
    private func configureSubviews() {
        [stackView, createButton, collectionView, emptyView].forEach { view.addSubview($0) }
        [emptyImageView, emptyLabel].forEach { emptyView.addSubview($0) }
        
    }
    
    private func configureConstraint() {
        createButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(50)
            $0.bottom.equalToSuperview().offset(-49)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(createButton.snp.top).offset(-15)
        }
        
        emptyView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(createButton.snp.top).offset(-30)
        }
        
        emptyImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyLabel.snp.makeConstraints {
            $0.top.equalTo(emptyImageView.snp.bottom).offset(32)
            $0.centerX.equalToSuperview()
        }
        
    }
    
    private func configureNavigation() {
        navigationItem.title = "도서 목록"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
        
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
            cell.configureUI(item: item)
            return cell
        })
    }
    
    
    // MARK: Actions
    
    @objc
    private func createButtonTouchUpInside() {
        let creatingFairyTaleViewController = CreateFairyTaleViewController()
        navigationController?.pushViewController(creatingFairyTaleViewController, animated: true)
    }
    
    // MARK: Network
    private func requestDiary() {
        let resoruce = Resource<[FairyListResponse]>(
            base: Utils.BASE_URL + "diary/all",
            method: .GET,
            paramaters: [:],
            header: ["Authorization": "Bearer \(KeychainWrapper.standard.string(forKey: Utils.ACCESS_TOEKN) ?? "")" ]
        )
        NetworkService.shared.load(resoruce) { [weak self] response in
            switch response {
            case .success(let response):
                DispatchQueue.main.async {
                    self?.emptyView.isHidden = !response.isEmpty
                }
                var snapShot = NSDiffableDataSourceSnapshot<Section, Item>()
                snapShot.appendSections([.main])
                snapShot.appendItems(response)
                self?.datasource?.apply(snapShot)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}


// MARK: UICollectionView Delegate

extension FairytaleListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = datasource?.itemIdentifier(for: indexPath) else { return }
        // TODO: 화면 이동
        let readingStoryViewController =  ReadingStoryViewController(id: item.fairyTaleId)
        navigationController?.pushViewController(readingStoryViewController, animated: true)
    }
}


// MARK: Enums

extension FairytaleListViewController {
    enum Section {
        case main
    }
    
    typealias Item = FairyListResponse
}

