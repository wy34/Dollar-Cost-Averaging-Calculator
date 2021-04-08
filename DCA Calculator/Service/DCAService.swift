//
//  DCAService.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import Foundation

struct DCAService {
    func calculate(asset: Asset, initialInvestmentAmount: Double, monthlyDollarCostAveraginAmount: Double, initialDateOfInvestmentIndex: Int) -> DCAResult {
        let investmentAmount = getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveraginAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        let numberOfShares = getNumberOfShares(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveraginAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        let latestSharePrice = getLatestSharePrice(asset: asset)
        let currentValue = getCurrentValue(numberOfShares: numberOfShares, latestSharePrice: latestSharePrice)
        
        let gain = currentValue - initialInvestmentAmount
        let yield = gain / initialInvestmentAmount
        let annualReturn = getAnnualReturn(currentValue: currentValue, investmentAmount: investmentAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        
        let isProfitable = currentValue >= initialInvestmentAmount
        
        return .init(currentValue: currentValue, investmentAmount: investmentAmount, gain: gain, yield: yield, annualReturn: annualReturn, isProfitable: isProfitable)
    }
    
    private func getAnnualReturn(currentValue: Double, investmentAmount: Double, initialDateOfInvestmentIndex: Int) -> Double {
        let rate = currentValue / investmentAmount
        let years = Double((initialDateOfInvestmentIndex + 1) / 12)
        return pow(rate, 1/years) - 1
    }
    
    private func getNumberOfShares(asset: Asset, initialInvestmentAmount: Double, monthlyDollarCostAveraginAmount: Double, initialDateOfInvestmentIndex: Int) -> Double {
        var totalShares = Double()
        
        let initialInvestmentOpenPrice = asset.timeSeriesMonthlyAdjusted.getMonthInfos()[initialDateOfInvestmentIndex].adjustedOpen
        let initialInvestShares = initialInvestmentAmount / initialInvestmentOpenPrice
        totalShares += initialInvestShares
        
        asset.timeSeriesMonthlyAdjusted.getMonthInfos().prefix(initialDateOfInvestmentIndex).forEach({ monthInfo in
            let dcaInvestmentShares = monthlyDollarCostAveraginAmount / monthInfo.adjustedOpen
            totalShares += dcaInvestmentShares
        })
        
        return totalShares
    }

    private func getLatestSharePrice(asset: Asset) -> Double {
        let latestPrice = asset.timeSeriesMonthlyAdjusted.getMonthInfos().first?.adjustedClose ?? 0
        return latestPrice
    }
    
    private func getCurrentValue(numberOfShares: Double, latestSharePrice: Double) -> Double {
        return (numberOfShares * latestSharePrice)
    }
    
    private func getInvestmentAmount(initialInvestmentAmount: Double, monthlyDollarCostAveraginAmount: Double, initialDateOfInvestmentIndex: Int) -> Double {
        var totalAmount = Double()
        totalAmount += initialInvestmentAmount
        let dollarCostAveragings = Double(initialDateOfInvestmentIndex) * monthlyDollarCostAveraginAmount
        totalAmount += dollarCostAveragings
        return totalAmount
    }
}

struct DCAResult {
    let currentValue: Double
    let investmentAmount: Double
    let gain: Double
    let yield: Double
    let annualReturn: Double
    let isProfitable: Bool
}
