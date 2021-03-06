//
//  KeyChainService.swift
//  LoginApp
//
//  Created by Jiaying Xie on 3/27/22.
//

import Foundation
import KeychainSwift

class KeychainService {
    var _keyChain = KeychainSwift()
    
    var keyChain : KeychainSwift {
        get {
            return _keyChain
        }
        
        set {
            _keyChain = newValue
        }
    }
}
