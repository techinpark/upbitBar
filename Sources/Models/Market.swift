//
//  Market.swift
//  upbitBar
//
//  Created by SUNG on 2021/03/18.
//

import Foundation

struct Market: Codable {
    let market, koreanName, englishName: String?

    enum CodingKeys: String, CodingKey {
        case market
        case koreanName = "korean_name"
        case englishName = "english_name"
    }
}
