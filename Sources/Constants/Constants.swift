//
//  Constants.swift
//  upbitBar
//
//  Created by SUNG on 2021/03/18.
//

import Foundation

enum Constants: String{
    case bearer = "Bearer"
    case authorization = "Authorization"
    case notionURL = "https://www.notion.so/UpbitBar-6b9cc7ab41474a9eaa5e9c69addd59e3"
}

enum UpbitKey: String{
    case accessKey
    case secretKey
    case refreshInterval
}


enum ServicesKey: String{
    case accessKey = "access_key"
    case nonce
    case hs256 = "HS256"
}
