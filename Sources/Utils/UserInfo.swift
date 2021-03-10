//
//  UserInfo.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/09.
//

import Foundation

@propertyWrapper
struct UserInfo<T> {
    private let key: String
    private let defaultValue: T

    
    var wrappedValue: T {
        get { return UserDefaults.standard.object(forKey: key) as? T ?? defaultValue }
        set { UserDefaults.standard.set(newValue, forKey: key) }
    }
    
    init(key: String, defaultValue: T) {
        self.key = key
        self.defaultValue = defaultValue
    }
}

struct UPbitKeys {
    @UserInfo(key: "accessKey", defaultValue: "") var accessToken: String
    @UserInfo(key: "secretKey", defaultValue: "") var secretToken: String
    @UserInfo(key: "refreshInterval", defaultValue: 1) var refershInterVal: Int
}
