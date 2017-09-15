//
//  Account.swift
//  MovieDisplay
//
//  Created by Coco Wu on 2017/9/14.
//  Copyright © 2017年 cyt. All rights reserved.
//

import Foundation

struct Account: Codable {
    var username:String?
    var phoneNum:String?
    var token:String?
    var tokenExpiresTime:String?
    var session:String?
    
    static public var defaultAccount:Account {
        get {
            let accountData:Data? = UserDefaults.standard.object(forKey: UserDefaultsKey.account) as? Data
            guard accountData != nil else {
                return Account()
            }
            let account = try! JSONDecoder().decode(Account.self, from: accountData!)
            return account
        }
    }
    
    static func saveAccount(_ newAccount:Account) {
        let data = try! JSONEncoder().encode(newAccount)
        UserDefaults.standard.set(data, forKey: UserDefaultsKey.account)
    }
    
    init() {
        
    }
}
