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
    
    // MARK: - Views
    private let initalAmtTextField = TextField(placeholder: "Enter your inital investment amount")
    private let initialAmtLabel = UIHostingController(rootView: TextFieldCaptionLabel(currency: "USD"))
    private lazy var amtStack = StackView(views: [initalAmtTextField, initialAmtLabel.view], axis: .vertical, alignment: .leading)
    
    private let monthlyDollarTextField = TextField(placeholder: "Monthly dollar cost averaging amount")
    private let monthlyDollarLabel = UIHostingController(rootView: TextFieldCaptionLabel(currency: "USD"))
    private lazy var monthlyStack = StackView(views: [monthlyDollarTextField, monthlyDollarLabel.view], axis: .vertical, alignment: .leading)

    private let initalDateTextField = TextField(placeholder: "Enter your inital date of investment")
    private let initialDateLabel = UIHostingController(rootView: TextFieldCaptionLabel(currency: "USD"))
    private lazy var dateStack = StackView(views: [initalDateTextField, initialDateLabel.view], axis: .vertical, alignment: .leading)
    
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
    }
    
    func configureWith(asset: Asset?) {
        guard let asset = asset else { return }
        initialAmtLabel.rootView.currency = asset.company.currency
        monthlyDollarLabel.rootView.currency = asset.company.currency
        initialDateLabel.rootView.currency = asset.company.currency
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
