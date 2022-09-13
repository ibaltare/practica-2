//
//  KeyChain.swift
//  AppMap
//
//  Created by Nicolas on 12/09/22.
//

import Foundation

final class KeyChain {

    static let standar = KeyChain()
    static let SERVICE = "keepcoding-app-map"
    private init() {}

    func save(data: String, service: String, account: String) {

        let dataCode = Data(data.utf8)
        let query = [
            kSecValueData: dataCode,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        let status = SecItemAdd(query, nil)

        if status == errSecDuplicateItem {

            let query = [
                kSecClass: kSecClassGenericPassword,
                kSecAttrService: service,
                kSecAttrAccount: account
            ] as CFDictionary

            let attributesToUpdate = [kSecValueData: dataCode] as CFDictionary
            SecItemUpdate(query, attributesToUpdate)
        }
        
        //if status != errSecSuccess {}
    }

    func read(service: String, account: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecReturnData: true
        ] as CFDictionary

        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        return (result as? Data)
    }

    func delete(service: String, account: String) {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ] as CFDictionary

        SecItemDelete(query)
    }

}
