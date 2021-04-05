//
//  ViewController.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import UIKit

class SearchVC: UIViewController {
    // MARK: - Properties
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CompanySearchCell.self, forCellReuseIdentifier: CompanySearchCell.reuseId)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
    
    private lazy var searchController: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchResultsUpdater = self
        sc.obscuresBackgroundDuringPresentation = false
        sc.searchBar.placeholder = "Enter a company name or symbol"
        sc.searchBar.autocapitalizationType = .allCharacters
        return sc
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }

    // MARK: - Helpers
    func layoutUI() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        navigationItem.searchController = searchController
    }
}

// MARK: - UITableViewDelegate, UITableViewDatasource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanySearchCell.reuseId, for: indexPath) as! CompanySearchCell
        return cell
    }
}

// MARK: - UISearchResultsUpdater
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text)
    }
}
