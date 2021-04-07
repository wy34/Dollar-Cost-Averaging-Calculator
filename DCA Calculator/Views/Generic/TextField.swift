//
//  TextField.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit

class TextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        self.font = .boldSystemFont(ofSize: 18)
    }
}
