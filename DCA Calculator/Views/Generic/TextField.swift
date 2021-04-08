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
        self.keyboardType = .decimalPad
        addDoneToolBar()
    }
    
    func addDoneToolBar() {
        let screenWidth = UIScreen.main.bounds.width
        let toolBar = UIToolbar(frame: .init(x: 0, y: 0, width: screenWidth, height: 50))
        toolBar.barStyle = .default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissKeyboard))
        toolBar.items = [flexSpace, doneButton]
        inputAccessoryView = toolBar
    }
    
    @objc func dismissKeyboard() {
        resignFirstResponder()
    }
}
