//
//  Button.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import UIKit

class Button: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(title: String, bgColor: UIColor, font: UIFont) {
        super.init(frame: .zero)
        self.init(type: .system)
        self.setTitle(title, for: .normal)
        self.backgroundColor = bgColor
        self.titleLabel?.font = font
        self.setTitleColor(#colorLiteral(red: 0.7670142055, green: 0.7677536607, blue: 0.7748499513, alpha: 1), for: .normal)
    }
}
