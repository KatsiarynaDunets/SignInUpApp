//
//  UserDefaultService.swift
//  SignInUpApp
//
//  Created by Kate on 30/08/2023.
//

import Foundation

// UserDefaults - это самоя простая БД в iOS
// работает по принципу ключ - значение
// БД очень медленная и предназначена только для простых типов данных
// Удаляется при удалении приложения!
// Работает по принципу one to one

final class UserDafultsService {
    // save user data:
    static func saveUserModel(userModel: UserModel) {
        /// Тут есть 2 решения:
        ///  1) перегнать userModel в формат Data и ее уже записывать
        ///  2) записывать отдельно каждое значение (делаем так)
        
        UserDefaults.standard.set(userModel.name, forKey: UserDefaults.Keys.name.rawValue)
        UserDefaults.standard.set(userModel.email, forKey: UserDefaults.Keys.email.rawValue)
        UserDefaults.standard.set(userModel.pass, forKey: UserDefaults.Keys.password.rawValue)
    }
    
    static func getUserModel() -> UserModel? {
        let name = UserDefaults.standard.string(forKey: UserDefaults.Keys.name.rawValue)
        guard let email = UserDefaults.standard.string(forKey: UserDefaults.Keys.email.rawValue),
              let pass = UserDefaults.standard.string(forKey: UserDefaults.Keys.password.rawValue) else { return nil }
        let userModel = UserModel(name: name, email: email, pass: pass)
        return userModel
    }
    
    static func cleanUserDefauts() {
        UserDefaults.standard.reset()
    }
}
