//
//  ViewController.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import UIKit

class DateVC: UIViewController {
    // MARK: - Properties
    var monthlyTimeSeriesAdjusted = [MonthInfo]()

    var didSelectDate: ((Int) -> Void)?
    var selectedDateIndex: Int?
    
    // MARK: - Init
    init(monthlyTimeSeriesAdjusted: TimeSeriesMonthlyAjusted?, selectedDateIndex: Int?) {
        super.init(nibName: nil, bundle: nil)
        guard let monthlyTimeSeriesAdjusted = monthlyTimeSeriesAdjusted else { return }
        self.monthlyTimeSeriesAdjusted = monthlyTimeSeriesAdjusted.getMonthInfos()
        self.selectedDateIndex = selectedDateIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Views
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(DateCell.self, forCellReuseIdentifier: DateCell.reuseId)
        tv.delegate = self
        tv.dataSource = self
        tv.tableFooterView = UIView()
        tv.keyboardDismissMode = .onDrag
        tv.rowHeight = 65
        return tv
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
    }
    
    // MARK: - Helpers
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
    }
    
    func setupSelectedDate(cell: UITableViewCell, indexPath: IndexPath) {
        guard let selectedDateIndex = selectedDateIndex else { return }
        cell.accessoryType = indexPath.row == selectedDateIndex ? .checkmark : .none
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension DateVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return monthlyTimeSeriesAdjusted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DateCell.reuseId, for: indexPath) as! DateCell
        setupSelectedDate(cell: cell, indexPath: indexPath)
        cell.configureWith(monthInfo: monthlyTimeSeriesAdjusted[indexPath.row], index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        didSelectDate?(indexPath.row)
        navigationController?.popViewController(animated: true)
    }
}
