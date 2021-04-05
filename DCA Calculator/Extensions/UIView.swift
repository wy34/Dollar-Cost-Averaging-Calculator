//
//  UIView.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/5/21.
//

import UIKit

extension UIView {
    // MARK: - Anchors
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, paddingTop:  CGFloat = 0, paddingTrailing: CGFloat = 0, paddingBottom: CGFloat = 0, paddingLeading: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let right = trailing {
            trailingAnchor.constraint(equalTo: right, constant: -paddingTrailing).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let left = leading {
            leadingAnchor.constraint(equalTo: left, constant: paddingLeading).isActive = true
        }
    }
    
    func setDimension(wConst: CGFloat? = nil, hConst: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let wConst = wConst {
            widthAnchor.constraint(equalToConstant: wConst).isActive = true
        }
        
        if let hConst = hConst {
            heightAnchor.constraint(equalToConstant: hConst).isActive = true
        }
    }
    
    func setDimension(width: NSLayoutDimension? = nil, height: NSLayoutDimension? = nil, wMult: CGFloat = 1, hMult: CGFloat = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let width = width {
            widthAnchor.constraint(equalTo: width, multiplier: wMult).isActive = true
        }
        
        if let height = height {
            heightAnchor.constraint(equalTo: height, multiplier: hMult).isActive = true
        }
    }
    
    func center(x: NSLayoutXAxisAnchor? = nil, y: NSLayoutYAxisAnchor? = nil, xPadding: CGFloat = 0, yPadding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let x = x {
            centerXAnchor.constraint(equalTo: x, constant: xPadding).isActive = true
        }
        
        if let y = y {
            centerYAnchor.constraint(equalTo: y, constant: yPadding).isActive = true
        }
    }
    
    func center(to view2: UIView, by attribute: NSLayoutConstraint.Attribute, withMultiplierOf mult: CGFloat = 1) {
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint(item: self, attribute: attribute, relatedBy: .equal, toItem: view2, attribute: attribute, multiplier: mult, constant: 0).isActive = true
    }
}
