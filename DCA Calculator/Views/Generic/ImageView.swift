//
//  ImageView.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit

class ImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(image: UIImage, contentMode: UIImageView.ContentMode) {
        super.init(frame: .zero)
        self.image = image
        self.contentMode = contentMode
    }
}
