//
//  CompanyCell.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import UIKit

class CompanySearchCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "CompanySearchCell"
    
    // MARK: - Views
    let symbolLabel = Label(text: "BA", font: .systemFont(ofSize: 20, weight: .heavy))
    let currencyLabel = Label(text: "USD", textColor: .lightGray, font: .systemFont(ofSize: 15))
    lazy var leftStack = StackView(views: [symbolLabel, currencyLabel], spacing: 3, axis: .vertical, alignment: .leading)
    
    let nameLabel = Label(text: "The Boeing Company", font: .systemFont(ofSize: 16), alignment: .right)
    lazy var overallStack = StackView(views: [leftStack, nameLabel], spacing: 3)

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    func layoutUI() {
        addSubview(overallStack)
        overallStack.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor, paddingTop: 16, paddingTrailing: 16, paddingBottom: 16, paddingLeading: 16)
        nameLabel.setDimension(width: widthAnchor, wMult: 0.5)
    }
    
    func configure(with company: Company) {
        nameLabel.text = company.name
        symbolLabel.text = company.symbol
        currencyLabel.text = company.type?.appending(" \(company.currency ?? "")")
    }
}
