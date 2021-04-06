//
//  Label.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import UIKit

class Label: UILabel {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(text: String, textColor: UIColor = .black, font: UIFont, alignment: NSTextAlignment = .left, numberOfLines: Int = 2) {
        super.init(frame: .zero)
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = alignment
        self.numberOfLines = numberOfLines
    }
}
