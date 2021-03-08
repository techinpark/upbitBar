//
//  RefreshInterval.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/09.
//

import Foundation

enum RefreshInterval: Int {
    case one = 0
    case five = 1
    case ten = 2
    case fifteen = 3
    
    var title: String {
        switch self {
        case .one: return NSLocalizedString("one_minutes", comment: "1 minutes")
        case .five: return NSLocalizedString("five_minutes", comment: "5 minutes")
        case .ten: return NSLocalizedString("ten_minutes", comment: "10 minutes")
        case .fifteen: return NSLocalizedString("fifteen_minutes", comment: "15 minutes")
        }
    }
    
    var minutes: Int {
        switch self {
        case .one: return 1
        case .five: return 5
        case .ten: return 10
        case .fifteen: return 15
        }
    }
}
