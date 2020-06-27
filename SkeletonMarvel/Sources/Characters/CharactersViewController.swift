//
//  CharactersViewController.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 15/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    lazy var collectionView: UICollectionView = {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let collectionView = UICollectionView(frame: view.bounds,
                                              collectionViewLayout: UICollectionViewCompositionalLayout.list(using: config))
        return collectionView
    }()
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Character>?
    var snapshot = NSDiffableDataSourceSnapshot<Section, Character>()
    
    private let viewModel: CharactersViewModelType
    
    init(viewModel: CharactersViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
        fetchList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fetchList() {
        viewModel.fetchCharacters { [weak self] result in
            self?.handleResult(result)
        }
    }
}

fileprivate extension CharactersViewController {
    func setupViews() {
        view.addSubview(collectionView)
        title = "Marvel Characters"
    }
    
    func setupCollectionView() {
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        configureDataSource()
    }
    
    func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<CharactersCollectionViewListCell, Character> { cell, indexPath, item in
            cell.update(with: item.name)
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, Character>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Character) -> UICollectionViewCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.characters)
        dataSource?.apply(snapshot, animatingDifferences: false)
    }
    
    func handleResult(_ result: Result<[Character], Error>) {
        switch result {
        case .success(let characters):
            snapshot.appendItems(characters)
            dataSource?.apply(snapshot, animatingDifferences: true)
        case .failure(let error):
            print("Error:", error)
        }
    }
}
