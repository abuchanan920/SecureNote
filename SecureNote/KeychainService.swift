//
//  KeychainService.swift
//  SecureNote
//
//  Created by Karan Krishnani on 11/6/16.
//  Copyright © 2016 ThoughtWorks. All rights reserved.
//

import Foundation
import Security

class KeychainService {
    private static let service = "SecureNote"
    private static let account = "UserSecret"
    
    static let sharedInstance = KeychainService()
    
    private let secret: Data

    init() {
        var data = Data(count: 32)
        _ = data.withUnsafeMutableBytes({ bytes in
            SecRandomCopyBytes(kSecRandomDefault, data.count, bytes)
        })
        self.secret = data
    }

    func storeSecret() -> Bool {
        var error: Unmanaged<CFError>?

        let secAccessControl = SecAccessControlCreateWithFlags(kCFAllocatorDefault, kSecAttrAccessibleWhenUnlockedThisDeviceOnly, .userPresence, &error)

        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrService as String: KeychainService.service,
            kSecAttrAccount as String: KeychainService.account,
            kSecValueData as String: secret,
            kSecUseAuthenticationUI as String: kCFBooleanTrue,
            kSecAttrAccessControl as String: secAccessControl!
        ]

        let resultStatus: OSStatus = SecItemAdd(query as CFDictionary, nil)
        return resultStatus == errSecSuccess
    }

    func lookupSecret() -> Bool {
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrService as String: KeychainService.service,
            kSecAttrAccount as String: KeychainService.account,
            kSecReturnData as String: kCFBooleanTrue,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecUseOperationPrompt as String: "Unlock your SecureNotes"
        ]

        var result: AnyObject?
        let resultStatus: OSStatus = SecItemCopyMatching(query as CFDictionary, &result)
        return resultStatus == errSecSuccess
    }

    func deleteSecret() -> Bool {
        let query: [String:Any] = [
            kSecClass as String: kSecClassGenericPassword as String,
            kSecAttrService as String: KeychainService.service,
            kSecAttrAccount as String: KeychainService.account
        ]

        let resultStatus: OSStatus = SecItemDelete(query as CFDictionary)
        return resultStatus == errSecSuccess
    }






















    
}
