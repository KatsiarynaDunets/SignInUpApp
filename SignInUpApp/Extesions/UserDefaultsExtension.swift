//
//  UserDefaultsExtension.swift
//  SignInUpApp
//
//  Created by Kate on 30/08/2023.
//

import Foundation

extension UserDefaults {
    
    /// CaseIterable - протокол, позволяющий enum (Keys) превратить в массив типа [String]
    enum Keys: String, CaseIterable {
        case email
        case name
        case password
    }
    
    func reset() {
        let allCases = Keys.allCases
        allCases.forEach {
            removeObject(forKey: $0.rawValue)
        }
    }
    
}
