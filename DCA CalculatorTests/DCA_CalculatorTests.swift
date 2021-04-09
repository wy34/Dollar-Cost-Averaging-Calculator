//
//  DCA_CalculatorTests.swift
//  DCA CalculatorTests
//
//  Created by William Yeung on 4/8/21.
//

import XCTest
@testable import DCA_Calculator

class DCA_CalculatorTests: XCTestCase {
    var sut: DCAService!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DCAService()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    
    // test cases
    // 1. asset = winning | dca = true => postive gain
    // 2. asset = winning | dca = false => positive gain
    // 3. asset = losing | dca = true => negative gain
    // 4. asset = winning | dca = false => negative gain
    
    // what
    // given
    // expectation
    
    func testResult_givenWinningAssetandDCAIsUsed_expectPositiveGains() {
        // given
        let initialInvestmentAmount: Double = 5000
        let monthlyDollarCostAveragingAmount: Double = 1500
        let initialDateOfInvestmentIndex = 5
        let asset = buildWinningAsset()
        // when
        let result = sut.calculate(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        // then
        XCTAssertEqual(result.investmentAmount, 12500)
        XCTAssertTrue(result.isProfitable)
        XCTAssertEqual(result.currentValue, 17342.224, accuracy: 0.1)
    }
    
    func testResult_givenWinningAssetandDCAIsNotUsed_expectPositiveGains() {
        // given
        let initialInvestmentAmount: Double = 5000
        let monthlyDollarCostAveragingAmount: Double = 0
        let initialDateOfInvestmentIndex = 3
        let asset = buildWinningAsset()
        // when
        let result = sut.calculate(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        // then
        XCTAssertEqual(result.investmentAmount, 5000)
        XCTAssertTrue(result.isProfitable)
        XCTAssertEqual(result.currentValue, 6666.666, accuracy: 0.1)
    }
    
    
    func testResult_givenLosingAssetandDCAIsUsed_expectNegativeGains() {
        // given
        let initialInvestmentAmount: Double = 5000
        let monthlyDollarCostAveragingAmount: Double = 1500
        let initialDateOfInvestmentIndex = 5
        let asset = buildLosingAsset()
        // when
        let result = sut.calculate(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        // then
        XCTAssertEqual(result.investmentAmount, 12500)
        XCTAssertTrue(result.isProfitable)
        XCTAssertEqual(result.currentValue, 9189.323, accuracy: 0.1)
    }
    
    func testResult_givenWinningAssetandDCAIsNotUsed_expectNegativeGains() {
        // given
        let initialInvestmentAmount: Double = 5000
        let monthlyDollarCostAveragingAmount: Double = 0
        let initialDateOfInvestmentIndex = 3
        let asset = buildLosingAsset()
        // when
        let result = sut.calculate(asset: asset, initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        // then
        XCTAssertEqual(result.investmentAmount, 5000)
        XCTAssertFalse(result.isProfitable)
        XCTAssertEqual(result.currentValue, 3666.666, accuracy: 0.1)
    }
    
    private func buildWinningAsset() -> Asset {
        let company = buildCompany()
        let timeSeries: [String: OHLC] = ["2021-01-25": OHLC(open: "100", close: "110", adjustedClose: "110"),
                                          "2021-02-25": OHLC(open: "110", close: "120", adjustedClose: "120"),
                                          "2021-03-25": OHLC(open: "120", close: "130", adjustedClose: "130"),
                                          "2021-04-25": OHLC(open: "130", close: "140", adjustedClose: "140"),
                                          "2021-05-25": OHLC(open: "140", close: "150", adjustedClose: "150"),
                                          "2021-06-25": OHLC(open: "150", close: "160", adjustedClose: "160")
                                        ]
        let timeSeriesMonthlyAdjusted = TimeSeriesMonthlyAjusted(meta: buildMeta(), timeSeries: timeSeries)
        return .init(company: company, timeSeriesMonthlyAdjusted: timeSeriesMonthlyAdjusted)
    }
    
    private func buildLosingAsset() -> Asset {
        let company = buildCompany()
        let timeSeries: [String: OHLC] = ["2021-01-25": OHLC(open: "170", close: "160", adjustedClose: "160"),
                                          "2021-02-25": OHLC(open: "160", close: "150", adjustedClose: "150"),
                                          "2021-03-25": OHLC(open: "150", close: "140", adjustedClose: "140"),
                                          "2021-04-25": OHLC(open: "140", close: "130", adjustedClose: "130"),
                                          "2021-05-25": OHLC(open: "130", close: "120", adjustedClose: "120"),
                                          "2021-06-25": OHLC(open: "120", close: "110", adjustedClose: "110")
                                        ]
        let timeSeriesMonthlyAdjusted = TimeSeriesMonthlyAjusted(meta: buildMeta(), timeSeries: timeSeries)
        return .init(company: company, timeSeriesMonthlyAdjusted: timeSeriesMonthlyAdjusted)
    }
    
    private func buildCompany() -> Company {
        return .init(symbol: "XYZ", name: "XYZ Company", type: "ETF", currency: "USD")
    }

    private func buildMeta() -> Meta {
        return .init(symbol: "XYZ")
    }
    
    func testInvestmentAmount_whenDCAIsUsed_expectedResult() {
        // given
        let initialInvestmentAmount: Double = 500
        let monthlyDollarCostAveragingAmount: Double = 300
        let initialDateOfInvestmentIndex = 4
        // when
        let investmentAmount = sut.getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        // then
        XCTAssertEqual(investmentAmount, 1700)
    }
    
    func testInvestmentAmount_whenDCAIsNotUsed_expectedResult() {
        // given
        let initialInvestmentAmount: Double = 500
        let monthlyDollarCostAveragingAmount: Double = 0
        let initialDateOfInvestmentIndex = 4
        // when
        let investmentAmount = sut.getInvestmentAmount(initialInvestmentAmount: initialInvestmentAmount, monthlyDollarCostAveraginAmount: monthlyDollarCostAveragingAmount, initialDateOfInvestmentIndex: initialDateOfInvestmentIndex)
        // then
        XCTAssertEqual(investmentAmount, 500)
    }
}
