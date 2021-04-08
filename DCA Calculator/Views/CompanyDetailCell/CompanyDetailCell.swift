//
//  CompanyDetailCell.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit
import SwiftUI


class CompanyDetailCell: UITableViewCell {
    // MARK: - Properties
    static let reuseId = "CompanyDetailCell"
    
    // MARK: - Views
    let hostingController = UIHostingController(rootView: CompanyDetailView())

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
        addSubview(hostingController.view)
        hostingController.view.anchor(top: topAnchor, trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor, paddingTop: 16, paddingTrailing: 16, paddingBottom: 16, paddingLeading: 16)
    }
    
    func configureWith(asset: Asset?) {
        guard let asset = asset else { return }
        hostingController.rootView.asset = asset
    }
}

// MARK: - Previews
struct CellView: UIViewRepresentable {
    func makeUIView(context: Context) -> CompanyDetailCell {
        let cell = CompanyDetailCell()
        return cell
    }
    
    func updateUIView(_ uiView: CompanyDetailCell, context: Context) {
        
    }
}

struct CellView_Previews: PreviewProvider {
    static var previews: some View {
        CellView()
    }
}
