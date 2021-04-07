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
    private let initialAmtLabel = Label(text: "Initial investment amount (USD)", textColor: .darkGray, font: .systemFont(ofSize: 14))
    private lazy var amtStack = StackView(views: [initalAmtTextField, initialAmtLabel], axis: .vertical, alignment: .leading)
    
    private let monthlyDollarTextField = TextField(placeholder: "Monthly dollar cost averaging amount")
    private let monthlyDollarLabel = Label(text: "Monthly dollar cost averaging amount (USD)", textColor: .darkGray, font: .systemFont(ofSize: 14))
    private lazy var monthlyStack = StackView(views: [monthlyDollarTextField, monthlyDollarLabel], axis: .vertical, alignment: .leading)

    private let initalDateTextField = TextField(placeholder: "Enter your inital date of investment")
    private let initialDateLabel = Label(text: "Initial date of investment (USD)", textColor: .darkGray, font: .systemFont(ofSize: 14))
    private lazy var dateStack = StackView(views: [initalDateTextField, initialDateLabel], axis: .vertical, alignment: .leading)
    
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
        overallStack.anchor(top: contentView.topAnchor, trailing: contentView.trailingAnchor, bottom: contentView.bottomAnchor, leading: contentView.leadingAnchor, paddingTop: 16, paddingTrailing: 16, paddingBottom: 16, paddingLeading: 16)
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
