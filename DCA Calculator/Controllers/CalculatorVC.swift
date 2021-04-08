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
    
    // MARK: - Properties
    var asset: Asset?
    var selectedDateIndex: Int?
    
    // MARK: - Init
    init(asset: Asset) {
        super.init(nibName: nil, bundle: nil)
        self.asset = asset
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureNavBar()
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: - Helpers
    private func layoutUI() {
        view.addSubview(tableView)
        tableView.anchor(top: view.topAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor)
    }
    
    func configureNavBar() {
        navigationItem.largeTitleDisplayMode = .never
    }
    
    func setSliderIndexValue(sliderIndex: Int) {
        self.selectedDateIndex = sliderIndex
    }
    
    // MARK: - Selectors
    @objc func handleKeyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            self.tableView.contentInset = .init(top: 0, left: 0, bottom: -keyboardHeight - 100, right: 0)
        }
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
                cell.configureWith(asset: asset)
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorCell.reuseId, for: indexPath) as! CalculatorCell
                cell.configureWith(asset: asset)
                cell.setSliderIndexValue = setSliderIndexValue(sliderIndex:)
                cell.showDateVC = { [weak self] in
                    guard let self = self else { return }
                    let vc = DateVC(monthlyTimeSeriesAdjusted: self.asset?.timeSeriesMonthlyAdjusted, selectedDateIndex: self.selectedDateIndex)
                    vc.didSelectDate = { row in
                        self.selectedDateIndex = row
                        let monthInfo = self.asset?.timeSeriesMonthlyAdjusted.getMonthInfos()[row]
                        cell.configureDateButton(title: monthInfo?.date.convertToString() ?? "")
                        cell.updateSlider(indexValue: row)
                    }
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                return cell
        }
    }
}
