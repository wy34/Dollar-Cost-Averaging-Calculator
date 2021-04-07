//
//  Slider.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit

class Slider: UISlider {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(minVal: Float, maxVal: Float) {
        super.init(frame: .zero)
        self.value = 0.5
        self.minimumValue = minVal
        self.maximumValue = maxVal
    }
}
