//
//  StackView.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import UIKit

class StackView: UIStackView {
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(views: [UIView], spacing: CGFloat = 0, axis: NSLayoutConstraint.Axis = .horizontal, alignment: UIStackView.Alignment = .center, distribution: UIStackView.Distribution = .fill) {
        super.init(frame: .zero)
        self.spacing = spacing
        self.axis = axis
        self.alignment = alignment
        self.distribution = distribution
        views.forEach({ self.addArrangedSubview($0) })
    }
}
