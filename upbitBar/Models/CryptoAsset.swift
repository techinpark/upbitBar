//
//  CryptoAsset.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/08.
//

import Foundation

// MARK: - CryptoAsset
struct CryptoAsset: Codable {
    let currency: String
    let balance: String
    let locked: String
    let avgBuyPrice: String
    let avgBuyPriceModified: Bool
    let unitCurrency: String

    enum CodingKeys: String, CodingKey {
        case currency = "currency"
        case balance = "balance"
        case locked = "locked"
        case avgBuyPrice = "avg_buy_price"
        case avgBuyPriceModified = "avg_buy_price_modified"
        case unitCurrency = "unit_currency"
    }
}
