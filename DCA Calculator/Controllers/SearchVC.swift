//
//  ViewController.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import UIKit
import Combine

class SearchVC: LoadingViewController {
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
        tv.keyboardDismissMode = .onDrag
        return tv
    }()
    
    let tableViewPlaceholder = SearchPlaceholderView()
    
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
        
        tableView.addSubview(tableViewPlaceholder)
        tableViewPlaceholder.center(to: self.tableView, by: .centerX)
        tableViewPlaceholder.center(to: self.tableView, by: .centerY, withMultiplierOf: 0.5)
        tableViewPlaceholder.setDimension(width: self.tableView.widthAnchor, height: self.tableView.heightAnchor, hMult: 0.3)
    }
    
    func configureNavBar() {
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Search"
    }
    
    private func fetchSymbols(searchTerm: String)  {
        apiService.fetchSymbols(searchTerm: searchTerm)
            .sink { (completion) in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                }
            } receiveValue: { [weak self] (searchResult) in
                guard let self = self else { return }
                self.companies = searchResult.items
                self.dismissLoader()
                self.tableView.reloadData()
            }
            .store(in: &subscribers)
    }
    
    private func fetchTimeSeries(symbol: String, company: Company) {
        showLoader()
        apiService.fetchTimeSeries(symbol: symbol)
            .sink { (completion) in
                switch completion {
                    case .finished:
                        break
                    case .failure(let error):
                        print(error)
                }
            } receiveValue: { [weak self] (timeSeriesMonthlyAdjusted) in
                guard let self = self else { return }
                self.dismissLoader()
                let asset = Asset(company: company, timeSeriesMonthlyAdjusted: timeSeriesMonthlyAdjusted)
                let vc = CalculatorVC(asset: asset)
                self.navigationController?.pushViewController(vc, animated: true)
            }
            .store(in: &subscribers)
    }
    
    private func setupSubscribers() {
        $searchQuery
            .debounce(for: .milliseconds(750), scheduler: RunLoop.main)
            .sink { [weak self] (searchQuery) in
                guard let self = self else { return }
                self.fetchSymbols(searchTerm: searchQuery)
            }
            .store(in: &subscribers)
        
        $isSearching
            .sink(receiveValue: { [weak self] (isSearching) in
                guard let self = self else { return }

                if isSearching {
                    self.tableViewPlaceholder.isHidden = true
                } else {
                    self.tableViewPlaceholder.isHidden = false
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let company = companies[indexPath.row]
        fetchTimeSeries(symbol: company.symbol, company: company)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UISearchResultsUpdater
extension SearchVC: UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard !searchController.searchBar.text!.isEmpty else {
            companies.removeAll()
            tableView.reloadData()
            isSearching = false
            print("removin")
            return
        }
        
        isSearching = true
        showLoader()
        searchQuery = searchController.searchBar.text!
    }
}

