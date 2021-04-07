//
//  CompanyDetailView.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import SwiftUI

struct CompanyDetailView: View {
    // MARK: - Properties
    var asset: Asset?
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(asset?.company.name ?? "")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                Text(asset?.company.type ?? "")
                    .foregroundColor(.gray)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
            }
            VStack(alignment: .leading) {
                HStack {
                    Text("Current Value")
                    Text("(\(asset?.company.currency ?? ""))")
                }
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                Text("5000")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            HStack {
                Text("Investment amount")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Spacer()
                Text("(\(asset?.company.currency ?? "")) 100")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            HStack {
                Text("Gain")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Spacer()
                Group {
                    Text("+100.25")
                    Text("(+10.25%)")
                        .foregroundColor(.green)
                }
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            HStack {
                Text("Annual return")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Spacer()
                Text("10.5%")
                    .foregroundColor(.green)
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
        }
    }
}

struct CompanyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailView()
    }
}

struct TextFieldCaptionLabel: View {
    var currency: String?
    
    var body: some View {
        HStack {
            Text("Initial investment amount (\(currency ?? ""))")
                .font(.system(size: 14, weight: .regular, design: .rounded))
                .foregroundColor(Color(.darkGray))
        }
    }
}
