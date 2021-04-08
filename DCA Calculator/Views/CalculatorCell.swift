//
//  CalculatorCell.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit
import SwiftUI

class CalculatorCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "CalculatorCell"
    
    var showDateVC: (() -> Void)?
    var setSliderIndexValue: ((Int) -> Void)?
    
    var monthInfos = [MonthInfo]()
    
    // MARK: - Views
    private let initalAmtTextField = TextField(placeholder: "Enter your inital investment amount")
    private let initialAmtLabel = UIHostingController(rootView: TextFieldCaptionLabel(caption: "Initial investment amount", currency: ""))
    private lazy var amtStack = StackView(views: [initalAmtTextField, initialAmtLabel.view], axis: .vertical, alignment: .leading)
    
    private let monthlyDollarTextField = TextField(placeholder: "Monthly dollar cost averaging amount")
    private let monthlyDollarLabel = UIHostingController(rootView: TextFieldCaptionLabel(caption: "Monthly dollar cost averaging amount", currency: ""))
    private lazy var monthlyStack = StackView(views: [monthlyDollarTextField, monthlyDollarLabel.view], axis: .vertical, alignment: .leading)

    private let initalDateButton = Button(title:  "Set your inital date of investment", bgColor: .clear, font: .boldSystemFont(ofSize: 18))
    private let initialDateLabel = UIHostingController(rootView: TextFieldCaptionLabel(caption: "Initial date of investment", currency: ""))
    private lazy var dateStack = StackView(views: [initalDateButton, initialDateLabel.view], spacing: -5, axis: .vertical,alignment: .leading)
    
    private let slider = Slider(minVal: 0, maxVal: 1)
    
    private lazy var overallStack = StackView(views: [amtStack, monthlyStack, dateStack, slider, UIView()], spacing: 8, axis: .vertical, alignment: .fill)
    
    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func layoutUI() {
        contentView.addSubview(overallStack)
        overallStack.anchor(top: contentView.topAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, paddingTop: 0, paddingTrailing: 16, paddingBottom: 16, paddingLeading: 16)
        
        initalDateButton.addTarget(self, action: #selector(handleDateButtonTapped), for: .touchUpInside)
    }
    
    func configureWith(asset: Asset?) {
        guard let asset = asset else { return }
        initialAmtLabel.rootView.currency = "(\(asset.company.currency ?? ""))"
        monthlyDollarLabel.rootView.currency = "(\(asset.company.currency ?? ""))"
        monthInfos = asset.timeSeriesMonthlyAdjusted.getMonthInfos()
        
        slider.addTarget(self, action: #selector(handleSlider(sender:)), for: .valueChanged)
        slider.minimumValue = 0
        slider.maximumValue = Float(monthInfos.count - 1)
    }
    
    func configureDateButton(title: String) {
        initalDateButton.setTitle(title, for: .normal)
        initalDateButton.setTitleColor(.black, for: .normal)
    }
    
    func updateSlider(indexValue: Int) {
        slider.value = Float(indexValue)
    }
    
    // MARK: - Selector
    @objc func handleDateButtonTapped() {
        showDateVC?()
    }
    
    @objc func handleSlider(sender: UISlider) {
        let value =  Int(sender.value)
        initalDateButton.setTitle(monthInfos[value].date.convertToString(), for: .normal)
        initalDateButton.setTitleColor(.black, for: .normal)
        setSliderIndexValue?(value)
    }
}

// MARK: - Previews
struct CalculatorCellView: UIViewRepresentable {
    func makeUIView(context: Context) -> CalculatorCell {
        let cell = CalculatorCell()
        cell.backgroundColor = .gray
        return cell
    }
    
    func updateUIView(_ uiView: CalculatorCell, context: Context) {
        
    }
}

struct CalculatorCellView_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorCellView()
    }
}
