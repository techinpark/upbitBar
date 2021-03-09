//
//  Attributes.swift
//  upbitBar
//
//  Created by Fernando on 2021/03/10.
//

import Foundation
import Cocoa

enum Attributes {
    
    static var cryptoRedAttributes: [NSAttributedString.Key: Any] {
        return [.font : NSFont.systemFont(ofSize: 12.0, weight: .light),
                .foregroundColor : NSColor(red: 197/255.0, green: 39/255.0, blue: 68/255.0, alpha: 1)
        ]
    }
    
    static var cryptoBlueAttributes: [NSAttributedString.Key: Any] {
        return [.font : NSFont.systemFont(ofSize: 12.0, weight: .light),
                .foregroundColor : NSColor(red: 39/255.0, green: 139/255.0, blue: 197/255.0, alpha: 1)
        ]
    }
    
    static var cryptoNormalAttributes: [NSAttributedString.Key: Any] {
        return [.font : NSFont.systemFont(ofSize: 12.0, weight: .light),
                .foregroundColor : NSColor.white
        ]
    }
}
