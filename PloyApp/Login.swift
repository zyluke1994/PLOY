//
//  Login.swift
//  Project2_Alex_Mai
//
//  Created by Alex Mai on 11/25/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class Login: NSObject, NSCoding {
    static let aLoginKey = "aLogin"
    static let aPasswordKey = "aPassword"
    
    var login: String
    var password: String
    
    override init() {
        login = ""
        password = ""
    }
    
    //encode login and password
    func encode(with aCoder: NSCoder) {
        aCoder.encode(login, forKey: Login.aLoginKey)
        aCoder.encode(password, forKey: Login.aPasswordKey)
    }
    
    //decode login and password
    required init?(coder aDecoder: NSCoder) {
        login = aDecoder.decodeObject(forKey: Login.aLoginKey) as! String
        password = aDecoder.decodeObject(forKey: Login.aPasswordKey) as! String
    }
    
}
