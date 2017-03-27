//
//  User.swift
//  Project1_Alex_Mai
//
//  Created by Alex Mai on 10/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import Foundation

//Class is an object that details personal info
class User:NSObject {
    var name: String
    var gender: String
    var age: Int
    var image: String
    
    init(_ name: String, _ gender:String, _ age:Int, _ image:String) {
        self.name = name
        self.gender = gender
        self.age = age
        self.image = image
    }
}
