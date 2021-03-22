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
        guard let secretKey = keys.secretToken.data(using: .utf8) else { return nil }
        let accessToken: String = keys.accessToken
        let nonce: String =  UUID().uuidString
                
        do {
            try jwtc.setValue(accessToken, forClaim: ServicesKey.accessKey.rawValue)
            try jwtc.setValue(nonce, forClaim: ServicesKey.nonce.rawValue)
            try jwtc.setValue(ServicesKey.hs256.rawValue, forHeaderParameter: .alg)
            try jwtc.sign(withKey: secretKey)
            
            guard let bearer = jwtc.jwt else { return nil }
            return "Bearer \(bearer)"
            
        } catch {
            return nil
        }
    }
    
    /// 나의 자산을 조회합니다
    func getBalances() -> [CryptoAsset]? {
        guard let bearerToken = generateJWTToken() else { return nil }
        let targetURL = UpbitAPI.balances.targetURL
        let headers: [String: String] = [Constants.authorization.rawValue: bearerToken]
        let response = Just.get(targetURL, headers: headers)
        guard let jsonData = response.content else { return nil }
        
        do {
            return try JSONDecoder().decode([CryptoAsset].self, from: jsonData)
        } catch {
            NotificationCenter.default.post(name: .neededTokenSetting, object: nil)
            print(error)
            return nil
        }
    }
    
    /// 현재가를 조회합니다
    func getTicker(markets: String) -> [Ticker]? {
        
        guard let bearerToken = generateJWTToken() else { return nil }
        let targetURL = "\(UpbitAPI.ticker.targetURL)?markets=\(markets)"
        print(targetURL)
        
        let headers: [String: String] = [Constants.authorization.rawValue: bearerToken]
        let response = Just.get(targetURL, headers: headers)
        
        guard let jsonData = response.content else { return nil }
        do{
            return try JSONDecoder().decode([Ticker].self, from: jsonData)
        } catch {
            print("error: \(error.localizedDescription)")
            print("response: \(String(describing: String(data: jsonData, encoding: .utf8)))")
            return nil
        }
    }
    
    // 업비트에서 거래 가능한 코인을 조회합니다
    func getAllMarket() -> [Market]?{
        let targetURL = "\(UpbitAPI.market.targetURL)all"
        let response = Just.get(targetURL)
        
        guard let jsonData = response.content else { return nil }
        do{
            return try JSONDecoder().decode([Market].self, from: jsonData)
        } catch {
            print("error: \(error.localizedDescription)")
            print("response: \(String(describing: String(data: jsonData, encoding: .utf8)))")
            return nil
        }
    }
}
