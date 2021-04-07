//
//  DateCell.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import UIKit

class DateCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "DateCell"
    
    // MARK: - Views
    let dateLabel = Label(text: "December 2020", textColor: .black, font: .boldSystemFont(ofSize: 16))
    let timeAgoLabel = Label(text: "Recent", textColor: .lightGray, font: .boldSystemFont(ofSize: 12))
    lazy var labelStack = StackView(views: [dateLabel, timeAgoLabel], axis: .vertical, alignment: .leading, distribution: .fillEqually)
    
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
        addSubview(labelStack)
        labelStack.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor, paddingTop: 8, paddingTrailing: 16, paddingBottom: 8, paddingLeading: 16)
    }
}
