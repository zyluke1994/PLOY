//
//  LoginTextPersister.swift
//  Project2_Alex_Mai
//
//  Created by Alex Mai on 11/25/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class LoginTextPersister: NSObject {
    static let loginTextPersisterURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("login.archive") as NSURL
    }()
    
    class func setLogin(_ login: Login) -> Bool {
        return NSKeyedArchiver.archiveRootObject(login, toFile: loginTextPersisterURL.path!)
    }
    
    class func getLogin() -> Login {
        if let login = NSKeyedUnarchiver.unarchiveObject(withFile: loginTextPersisterURL.path!) as? Login {
            return login
        }
        else {
            return Login()
        }
    }
    
}
