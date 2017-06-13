//
//  LoginController.swift
//  travel-planning_iOs
//
//  Created by Admin on 23.04.17.
//  Copyright © 2017 Александр Сивцов. All rights reserved.
//

import Foundation

class LoginController {
    
    private let TOKEN_KEY = "token"
    
    private var userDefaults = UserDefaults.standard
    
    func checkAuth() -> Bool {
        if let token = loadToken() {
            return checkAuthOnServer(with: token)
        } else {
            return false
        }
    }
    
    func auth(login: String, password: String) -> Bool {
        let optToken = authOnServer(login: login, password: password)
        if let token = optToken {
            saveToken(token)
            return true
        } else {
            return false
        }
    }
    
    private func saveToken(_ token: String) {
        userDefaults.set(token, forKey: TOKEN_KEY)
        userDefaults.synchronize()
    }
    
    private func loadToken() -> String? {
        return userDefaults.object(forKey: TOKEN_KEY) as! String?
    }
    
    private func authOnServer(login: String, password: String) -> String? {
        return "TOKEN" //TODO: implement
    }
    
    private func checkAuthOnServer(with token: String) -> Bool {
        return token == "TOKEN" // TODO: implement
    }
}
