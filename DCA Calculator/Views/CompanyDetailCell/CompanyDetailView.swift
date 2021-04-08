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
    @State private var dcaResult: DCAResult?
    let calculatorNotification = NotificationCenter.default.publisher(for: CalculatorCell.calculateNotification)
    
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
                Text("\(dcaResult?.currentValue.toTwoPlaces() ?? 0.0.toTwoPlaces())")
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            HStack {
                Text("Investment amount")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Spacer()
                Text("\(asset?.company.currency ?? "") \(dcaResult?.investmentAmount.toTwoPlaces() ?? 0.0.toTwoPlaces())")
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
            .onReceive(calculatorNotification) { (output) in
                if let userInfo = output.userInfo {
                    if let dcaResult = userInfo["result"] as? DCAResult {
                        self.dcaResult = dcaResult
                    }
                }
            }
    }
}

struct CompanyDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CompanyDetailView()
    }
}
