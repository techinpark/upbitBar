//
//  UserInfo.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/09.
//

import Foundation

@propertyWrapper
struct UserInfo {
    private let key: String
    
    var wrappedValue: String {
        get { UserDefaults.standard.string(forKey: key) ?? "" }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String) {
        self.key = key
    }
}

struct UPbitKeys {
       @UserInfo(key: "accessToken") var accessToken: String
       @UserInfo(key: "refreshToken") var refreshToken: String
}
