//
//  UPbitAPI.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/08.
//

import Foundation

enum UpbitAPI {
    
    /// 나의 자산을 조회합니다
    case balances
    
    /// 현재가를 조회합니다
    case ticker
}

extension UpbitAPI {
    
    /// baseURL 을 지정합니다
    var baseURL: String {
        return "https://api.upbit.com"
    }
    
    /// API Version
    var version: String {
        return "v1"
    }
    
    /// endpoint를 지정합니다
    var endPoint: String {
        switch self {
        case .balances:
            return "/\(version)/accounts/"
        case .ticker:
            return "/\(version)/ticker/"
        }
    }
    
    var targetURL: String {
        return baseURL + endPoint
    }
}
