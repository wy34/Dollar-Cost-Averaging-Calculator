//
//  DCAService.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/7/21.
//

import Foundation

struct DCAService {
    func calculate(initialInvestmentAmount: Double, monthlyDollarCostAveraginAmount: Double, initialDateOfInvestmentIndex: Int) -> DCAResult {
        let investmentAmount = getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveraginAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        print(initialInvestmentAmount)
        print(monthlyDollarCostAveraginAmount)
        print(initialDateOfInvestmentIndex)
        print(investmentAmount)
        
        return .init(currentValue: 10, investmentAmount: investmentAmount, gain: 0, yield: 0, annualReturn: 0)
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
}
