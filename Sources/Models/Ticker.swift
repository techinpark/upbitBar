//
//  Ticker.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/08.
//

import Foundation

// MARK: - Ticker

/// Document URL
/// https://docs.upbit.com/reference#ticker%ED%98%84%EC%9E%AC%EA%B0%80-%EB%82%B4%EC%97%AD

struct Ticker: Codable {
    
    /// 종목구분코드
    let market: String
    /// 최근거래일자 (UTC)
    let tradeDate: String
    /// 최근 거래시각 (UTC)
    let tradeTime: String
    /// 최근 거래일자 (KST)
    let tradeDateKst: String
    /// 최근 거래시각 (KST)
    let tradeTimeKst: String
    /// 최근 거래시간 타임스탬프
    let tradeTimestamp: Int
    /// 시가
    let openingPrice: Double
    /// 고가
    let highPrice: Double
    /// 저가
    let lowPrice: Double
    /// 종가
    let tradePrice: Double
    /// 전일종가
    let prevClosingPrice: Double
    /// 변화 (EVENT: 보합, RISE: 상승, FALL: 하락)
    let change: String
    /// 변화액의 절대값
    let changePrice: Double
    /// 변화율의 절대값
    let changeRate: Double
    /// 부호가 있는 변화액
    let signedChangePrice: Double
    /// 부호가 있는 변화율
    let signedChangeRate: Double
    /// 가장최근 거래량
    let tradeVolume: Double
    /// 누적거래대금 (UTC 0시 기준)
    let accTradePrice: Double
    /// 24시간 누적 거래량
    let accTradePrice24H: Double
    /// 누적거래량 (UTC 0시 기준)
    let accTradeVolume: Double
    /// 24시간 누적 거래량
    let accTradeVolume24H: Double
    /// 52주 신고가
    let highest52_WeekPrice: Double
    /// 52주 신고가 달성일
    let highest52_WeekDate: String
    /// 52주 신저가
    let lowest52_WeekPrice: Double
    /// 52주 신저가 달성일
    let lowest52_WeekDate: String
    /// 타임스탬프
    let timestamp: UInt

    enum CodingKeys: String, CodingKey {
        case market = "market"
        case tradeDate = "trade_date"
        case tradeTime = "trade_time"
        case tradeDateKst = "trade_date_kst"
        case tradeTimeKst = "trade_time_kst"
        case tradeTimestamp = "trade_timestamp"
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case change = "change"
        case changePrice = "change_price"
        case changeRate = "change_rate"
        case signedChangePrice = "signed_change_price"
        case signedChangeRate = "signed_change_rate"
        case tradeVolume = "trade_volume"
        case accTradePrice = "acc_trade_price"
        case accTradePrice24H = "acc_trade_price_24h"
        case accTradeVolume = "acc_trade_volume"
        case accTradeVolume24H = "acc_trade_volume_24h"
        case highest52_WeekPrice = "highest_52_week_price"
        case highest52_WeekDate = "highest_52_week_date"
        case lowest52_WeekPrice = "lowest_52_week_price"
        case lowest52_WeekDate = "lowest_52_week_date"
        case timestamp = "timestamp"
    }
}
