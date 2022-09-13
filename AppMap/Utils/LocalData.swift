//
//  LocalData.swift
//  AppMap
//
//  Created by Nicolas on 12/09/22.
//

import Foundation

final class LocalData {
    private static let userDefaults = UserDefaults.standard
    private static let Email = "email"
    
    static func getEmail() -> String? {
        userDefaults.string(forKey: LocalData.Email)
    }
  
    static func save(email: String) {
        userDefaults.set(email, forKey: LocalData.Email)
    }
  
    static func deleteEmail() {
        userDefaults.removeObject(forKey: LocalData.Email)
    }
}
