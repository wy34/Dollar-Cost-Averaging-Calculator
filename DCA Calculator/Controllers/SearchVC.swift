//
//  ViewController.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import UIKit
import Combine

class SearchVC: UIViewController {
    // MARK: - Properties
    private let apiService = APIService()
    private var subscribers = Set<AnyCancellable>()
    @Published private var searchQuery = String()
    
    private var companies = [Company]()
    
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
        observeFrom()
    }

    // MARK: - Helpers
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
        navigationItem.searchController = searchController
    }
    
    private func performSearch(searchTerm: String) {
        apiService.fetchSymbolsPublisher(keywords: searchTerm)
            .sink { (completion) in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                }
                } receiveValue: { [weak self] (searchResults) in
                    guard let self = self else { return }
                    self.companies = searchResults.items
                    DispatchQueue.main.async { self.tableView.reloadData() }
                }
            .store(in: &subscribers)
    }
    
    private func observeFrom() {
        $searchQuery
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink { (searchQuery) in
                print(searchQuery)
            }
            .store(in: &subscribers)
    }
}

// MARK: - UITableViewDelegate, UITableViewDatasource
extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanySearchCell.reuseId, for: indexPath) as! CompanySearchCell
        return cell
    }
}

// MARK: - UISearchResultsUpdater
extension SearchVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchQuery = searchController.searchBar.text, !searchQuery.isEmpty else {
            return
        }
        self.searchQuery = searchQuery
    }
}
