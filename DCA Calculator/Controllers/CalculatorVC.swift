//
//  CalculatorVC.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit

class CalculatorVC: UIViewController {
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CompanyDetailCell.self, forCellReuseIdentifier: CompanyDetailCell.reuseId)
        tv.register(CalculatorCell.self, forCellReuseIdentifier: CalculatorCell.reuseId)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.keyboardDismissMode = .onDrag
        tv.allowsSelection = false
        tv.separatorStyle = .none
        return tv
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureNavBar()
    }
    
    // MARK: - Helpers
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
    }
    
    func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Search"
    }
}


// MARK: - UITableViewDelegate, UITableViewDatasource
extension CalculatorVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: CompanyDetailCell.reuseId, for: indexPath) as! CompanyDetailCell
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorCell.reuseId, for: indexPath) as! CalculatorCell
                return cell
        }
    }
}
