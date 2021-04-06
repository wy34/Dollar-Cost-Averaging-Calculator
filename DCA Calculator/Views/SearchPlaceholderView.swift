//
//  SearchPlaceholderView.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit

class SearchPlaceholderView: UIView {
    // MARK: - Properties
    
    // MARK: - Views
    let imageView = ImageView(image: UIImage(named: "ph")!, contentMode: .scaleAspectFit)
    let titleLabel = Label(text: "Search for companies to calculate potential returns via dollar cost averaging.", font: .systemFont(ofSize: 14), alignment: .center, numberOfLines: 0)
    lazy var stackView = StackView(views: [imageView, titleLabel], spacing: 5, axis: .vertical)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Helper
    func layoutUI() {
        addSubview(stackView)
        stackView.center(x: centerXAnchor, y: centerYAnchor)
        imageView.setDimension(width: widthAnchor, height: widthAnchor, wMult: 0.3, hMult: 0.3)
        titleLabel.setDimension(width: widthAnchor, height: heightAnchor, wMult: 0.75, hMult: 0.3)
    }
}
