//
//  UpbitServices.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/08.
//

import Foundation
import JWTComponents
import Just

/// MARK: UpbitServices

class UpbitServices {
    
    static let shared = UpbitServices()
    
    private let keys = UPbitKeys()
 
    /// JWT 토큰을 생성합니다
    func generateJWTToken() -> String? {
        
        var jwtc = JWTComponents()
        let secretKey = keys.secretToken.data(using: .utf8)!
        let accessToken: String = keys.accessToken
        let nonce: String =  UUID().uuidString
                
        do {
            try jwtc.setValue(accessToken, forClaim: "access_key")
            try jwtc.setValue(nonce, forClaim: "nonce")
            try jwtc.setValue("HS256", forHeaderParameter: .alg)
            try jwtc.sign(withKey: secretKey)
            
            if let bearer = jwtc.jwt {
                return "Bearer \(bearer)"
            }
        } catch {
            return nil
        }
        
        return nil
    }
    
    /// 나의 자산을 조회합니다
    func getBalances() -> [CryptoAsset]? {
        
        if let bearerToken = generateJWTToken() {
            let targetURL = UpbitAPI.balances.targetURL
            let headers: [String: String] = ["Authorization": bearerToken]
            let response = Just.get(targetURL, headers: headers)
            let jsonData = response.content!
            
            do {
                let result = try JSONDecoder().decode([CryptoAsset].self, from: jsonData)
                return result
            } catch {
                NotificationCenter.default.post(name: .neededTokenSetting, object: nil)
                print(error)
                return nil
            }
        }
        
        return nil
    }
    
    /// 현재가를 조회합니다
    func getTicker(markets: String) -> [Ticker]? {
        
        if let bearerToken = generateJWTToken() {
            let targetURL = "\(UpbitAPI.ticker.targetURL)?markets=\(markets)"
            print(targetURL)
            let headers: [String: String] = ["Authorization": bearerToken]
            let response = Just.get(targetURL, headers: headers)
            let jsonData = response.content!
          do {
            let result = try JSONDecoder().decode([Ticker].self, from: jsonData)
            return result
          } catch let error {
            print(error.localizedDescription)
          }
            
        }
        
        return nil
    }
}
