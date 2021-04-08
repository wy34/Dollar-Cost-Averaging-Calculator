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
                Text(dcaResult?.currentValue.currencyValue() ?? "$0.00")
                    .foregroundColor((dcaResult == nil || dcaResult!.currentValue == 0.0) ? Color(.label) : (dcaResult!.isProfitable ? Color(.systemGreen) : Color(.systemRed)))
                    .font(.system(size: 20, weight: .bold, design: .rounded))
            }
            HStack {
                Text("Investment amount")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Spacer()
                Text("\(asset?.company.currency ?? "") \(dcaResult?.investmentAmount.currencyValue() ?? "$0.00")")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            HStack {
                Text("Gain")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Spacer()
                Group {
                    Text("\((dcaResult == nil) ? "" : (dcaResult!.isProfitable ? "+" : ""))\((dcaResult?.gain ?? 0.000), specifier: "%.3f")")
                    Text("(\((dcaResult == nil) ? "" : (dcaResult!.isProfitable ? "+" : ""))\((dcaResult?.yield ?? 0.00), specifier: "%.2f")%)")
                        .foregroundColor((dcaResult == nil || dcaResult!.gain == 0) ? Color(.label) : (dcaResult!.isProfitable ? Color(.systemGreen) : Color(.systemRed)))
                }
                    .font(.system(size: 14, weight: .bold, design: .rounded))
            }
            HStack {
                Text("Annual return")
                    .font(.system(size: 14, weight: .regular, design: .rounded))
                Spacer()
                Text("\((dcaResult == nil) ? "" : (dcaResult!.isProfitable ? "+" : ""))\((dcaResult?.annualReturn ?? 0.00), specifier: "%.2f")%")
                    .foregroundColor((dcaResult == nil || dcaResult!.gain == 0) ? Color(.label) : (dcaResult!.isProfitable ? Color(.systemGreen) : Color(.systemRed)))
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
