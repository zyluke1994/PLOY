//
//  AccountDataSource.swift
//  Project3_Alex_Mai
//
//  Created by Alex Mai on 12/8/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit
import CoreData

class AccountDataSource: NSObject {
    var accounts: [Account]
    static var whoAmI = ""
    
    override init() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = delegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<Account>(entityName: "Account")
            
            do {
                accounts = try managedContext.fetch(fetchRequest)
            }
            catch let error as NSError {
                print("Failed to load persistent data. \(error), \(error.userInfo)")
                accounts = [Account]()
            }
        }
        else {
            accounts = [Account]()
        }
        
        super.init()
    }
    
    //
    // MARK: account management (creation and persistence)
    //
    
//    func getAccount(login: String) -> Account? {
//        if let account = findAccount(with: login) {
//            return account
//        }
//        else {
//            return newAccount(with: login)
//        }
//    }
    
    func validatedAccount(_ login: String, _ password: String) -> Bool {
        for account in accounts {
            if account.login == login {
                AccountDataSource.whoAmI = login
                return true
            }
        }
        return false
    }
    
    func newAccount(_ name: String, _ gender: String, _ age: Int32, _ image: String, _ login:String, _ password: String, _ email:String, _ emergencyContact:String) -> Bool {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Account", in: managedContext)!
        
        //similar to insert in sql language
        let account = Account(entity: entity, insertInto: managedContext)
        account.name = name
        account.gender = gender
        account.age = age
        account.image = image
        account.login = login
        account.password = password
        account.email = email
        account.emergencyContact = emergencyContact
        
        
        do {
            try managedContext.save()
            accounts.append(account)
            save()
            return true
        }
        catch let error as NSError {
            print("Failed to save Account.  \(error), \(error.userInfo)")
            return false
        }
    }
    
//    func deleteAccount(entree: Entree) {
//        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
//            print("Failed to save.")
//            return
//        }
//        
//        if let index = entrees.index(of: entree) {
//            
//            let managedContext = delegate.persistentContainer.viewContext
//            
//            managedContext.delete(entree)
//            
//            entrees.remove(at: index)
//        }
//        
//        save()
//    }
    
    func save() {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            print("Failed to save.")
            return
        }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        do {
            try managedContext.save()
        }
        catch let error as NSError {
            print("Failed to save. \(error), \(error.userInfo)")
        }
    }

    //for registration - validate the login doesn't already exist
    func matchesOtherLogin(_ login: String) -> Bool {
        for i in 0..<accounts.count {
            //if the login matches one that's already in the accounts array, return false
            if login == accounts[i].login {
                return true
            }
        }

        return false
    }

    //for ThirdViewController to display user info
    func getAccountIndex(_ login: String) -> Int {
        var accountIndex: Int = 0
        for i in 0..<accounts.count {
            if login == accounts[i].login {
                accountIndex = i
            }
        }
        
        return accountIndex
    }

    
}
