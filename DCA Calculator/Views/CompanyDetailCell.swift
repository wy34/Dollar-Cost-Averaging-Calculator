//
//  CompanyDetailCell.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit
import SwiftUI

class CompanyDetailCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "CompanyDetailCell"
    
    // MARK: - Views
    let nameLabel = Label(text: "SPY", font: .boldSystemFont(ofSize: 20))
    let typeLabel = Label(text: "S&P 500 ETF", textColor: .lightGray, font: .systemFont(ofSize: 14), alignment: .right, numberOfLines: 1)
    lazy var topStack = StackView(views: [nameLabel, typeLabel], alignment: .fill)
    
    let currentValLabel = Label(text: "Current Value", font: .systemFont(ofSize: 14))
    let currencyLabel = Label(text: "(USD)", font: .systemFont(ofSize: 14))
    lazy var currencyStack = StackView(views: [currentValLabel, currencyLabel], spacing: 5)
    let valueLabel = Label(text: "5000", font: .boldSystemFont(ofSize: 24))
    lazy var valueStack = StackView(views: [currencyStack, valueLabel], axis: .vertical, alignment: .leading)
    
    let amountLabel = Label(text: "Investment Amount", font: .systemFont(ofSize: 14))
    let amount = Label(text: "USD 100", font: .systemFont(ofSize: 14), alignment: .right)
    lazy var amountStack = StackView(views: [amountLabel, amount])

    let gainLabel = Label(text: "Gain", font: .systemFont(ofSize: 14))
    let gain = Label(text: "+100.25 (+10.25%)", font: .systemFont(ofSize: 14), alignment: .right)
    lazy var gainStack = StackView(views: [gainLabel, gain])
    
    let annualReturnLabel = Label(text: "Annual Return", font: .systemFont(ofSize: 14))
    let annualReturn = Label(text: "10.5%", font: .systemFont(ofSize: 14), alignment: .right)
    lazy var annualReturnStack = StackView(views: [annualReturnLabel, annualReturn])
    
    lazy var overallStack = StackView(views: [topStack, valueStack, amountStack, gainStack, annualReturnStack, UIView()], spacing: 8, axis: .vertical, alignment: .fill)

    // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
//        nameLabel.backgroundColor = .red
//        typeLabel.backgroundColor = .blue
//        currentValLabel.backgroundColor = .orange
//        currencyLabel.backgroundColor = .purple
//        valueLabel.backgroundColor = .yellow
//        annualReturnLabel.backgroundColor = .blue
//         gainLabel.backgroundColor = .green
//         amountLabel.backgroundColor = .orange
//         gain.backgroundColor = .purple
//         annualReturn.backgroundColor = .yellow
//         amount.backgroundColor = .red
        nameLabel.setContentCompressionResistancePriority(.init(0), for: .horizontal)
 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helpers
    func layoutUI() {
        addSubview(overallStack)
        overallStack.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor, paddingTop: 16, paddingTrailing: 16, paddingBottom: 16, paddingLeading: 16)
    }
}

// MARK: - Previews
struct CellView: UIViewRepresentable {
    func makeUIView(context: Context) -> CompanyDetailCell {
        let cell = CompanyDetailCell()
        return cell
    }
    
    func updateUIView(_ uiView: CompanyDetailCell, context: Context) {
        
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView()
            .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 200))
        
    }
}
