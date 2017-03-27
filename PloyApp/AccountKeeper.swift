//
//  AccountKeeper.swift
//  Project1_Alex_Mai
//
//  Created by Alex Mai on 10/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import Foundation

class AccountKeeper: NSObject{
    var accounts: [Account] = [Account("Donald Trump", "Male", 8, "trump.jpg", "admin", "password", "donald.trump@trump.com", "hillary.clinton@clinton.com"), Account("Hillary Clinton", "Female", 90, "clinton.jpg", "hillary", "clinton", "hillary.clinton@clinton.com", "donald.trump@trump.com")]
    
    
    func addAccount() {
        
    }
    
    func validatedAccount(_ login:String, _ password:String) -> Bool {
        
        for i in 0..<accounts.count {
            if login == accounts[i].login && password == accounts[i].password {
                return true
            }
        }
        
        return false
    }
    
    
}
