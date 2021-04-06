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
    private var companies = [Company]()
    private var subscribers = Set<AnyCancellable>()
    @Published private var searchQuery = String()
    @Published private var isSearching = false

    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CompanySearchCell.self, forCellReuseIdentifier: CompanySearchCell.reuseId)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
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
        configureNavBar()
        setupSubscribers()
    }

    // MARK: - Helpers
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
    }
    
    func configureNavBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
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
                    self.tableView.reloadData()
                }
            .store(in: &subscribers)
    }
    
    private func setupSubscribers() {
        $searchQuery
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink { [weak self] (searchQuery) in
                guard let self = self else { return }
                self.performSearch(searchTerm: searchQuery)
            }
            .store(in: &subscribers)
        
        $isSearching
            .sink(receiveValue: { [weak self] (isSearching) in
                guard let self = self else { return }
                let v = SearchPlaceholderView()
                
                if isSearching {
                    v.isHidden = true
                } else {
                    self.tableView.addSubview(v)
                    v.center(to: self.tableView, by: .centerX)
                    v.center(to: self.tableView, by: .centerY, withMultiplierOf: 0.5)
                    v.setDimension(width: self.tableView.widthAnchor, height: self.tableView.heightAnchor, hMult: 0.3)
                }
            })
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
        cell.configure(with: companies[indexPath.row])
        return cell
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        return SearchPlaceholderView()
//    }
//
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 400
//    }
}

// MARK: - UISearchResultsUpdater
extension SearchVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard !searchController.searchBar.text!.isEmpty else {
            companies.removeAll()
            tableView.reloadData()
            isSearching = false
            return
        }
        
        isSearching = true
        self.searchQuery = searchController.searchBar.text!
    }
}
