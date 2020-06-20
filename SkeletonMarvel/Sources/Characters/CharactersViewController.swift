//
//  CharactersViewController.swift
//  SkeletonMarvel
//
//  Created by Mathilde Ferrand on 15/06/2020.
//  Copyright © 2020 Mathilde Ferrand. All rights reserved.
//

import UIKit

final class CharactersViewController: UIViewController {
    
    let tableViewController: UITableViewController = UITableViewController(style: .plain)
    private let viewModel: CharactersViewModelType
    private var shouldAnimate: Bool = true
    
    var tableView: UITableView {
        return tableViewController.tableView
    }
    
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
        setupTableView()
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
        view.addSubview(tableView)
        view.backgroundColor = .white
        tableView.backgroundColor = .white
        title = "Marvel Characters"
        
        initializeConstraints()
    }
    
    func setupTableView() {
        viewModel.setupPlaceholders()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier())
        tableView.register(CharactersTableViewCell.self, forCellReuseIdentifier: CharactersTableViewCell.reuseIdentifier())
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func initializeConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints: [NSLayoutConstraint] = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func handleResult(_ result: Result<[Character], Error>) {
        shouldAnimate = false
        switch result {
        case .success:
            self.tableView.reloadData()
        case .failure(let error):
            print("Error:", error)
        }
    }
}

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CharactersTableViewCell.reuseIdentifier(), for: indexPath) as? CharactersTableViewCell else {
            return UITableViewCell()
        }
        let item = viewModel.characters[indexPath.row]
        cell.update(with: item.name)
        
        if self.shouldAnimate {
            cell.startAnimation()
        } else {
            cell.stopAnimation()
        }
        
        return cell
    }
}

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // for another time
    }
}

extension UITableViewCell {
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
