//
//  ViewController.swift
//  Project1_Alex_Mai
//
//  Created by Alex Mai on 10/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit
import CoreLocation

//This class handles the login
class ViewController: UIViewController, UITextFieldDelegate, CLLocationManagerDelegate {
    
    //MARK: Initializing custom data
    var loginTextFields: Login!
    var accounts: AccountDataSource!
    let locationManager = CLLocationManager() //for use in 5th VC
    
    //MARK: Outlets
    @IBOutlet var loginText: UITextField!
    @IBOutlet var passwordText: UITextField!

    //MARK: Action
    @IBAction func loginTextChanged(sender: UITextField) {
        if let loginValue = loginText.text {
            loginTextFields.login = loginValue
        }
    }
    @IBAction func passwordTextChanged(sender: UITextField) {
        if let passwordValue = passwordText.text {
            loginTextFields.password = passwordValue
        }
    }
    
    //Gesture recognize to dismiss keyboard
    @IBAction func dismissKeyboard(sender: AnyObject) {
        loginText.resignFirstResponder()
        passwordText.resignFirstResponder()
    }
    
    //Login button pressed
    @IBAction func loginButtonPressed(sender: UIButton) {
        
        //if login and password validates, then move to next view
        if let userLogin = loginText.text, let userPassword = passwordText.text {
            
            let userLoginLower = userLogin.lowercased()
            
            if accounts.validatedAccount(userLoginLower, userPassword) {
                let navController = self.storyboard!.instantiateViewController(withIdentifier: "NavController")
                
                print("Login successful")
                print(AccountDataSource.whoAmI)
                
                self.present(navController, animated:true, completion: nil)
            }
        }

    }
    
    //Delegate - Make sure "/" cannot be used in textfields to prevent injections
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {

        switch string {
            case "/", " ", "\\":
                return false
            default:
                return true
        }
    
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    //automatically log the user in if the credentials are right
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loginText.text = loginTextFields.login
        passwordText.text = loginTextFields.password
        
        //must create accounts instance here to update after the user registers
        accounts = AccountDataSource()
        
        //when app running request permission from user to use location
        locationManager.requestAlwaysAuthorization()
        
        //when app is in foreground request
        locationManager.requestWhenInUseAuthorization()
        
//        if let login = loginText.text, let password = passwordText.text {
//            checkLogin(login, password)
//        }
    }

    //does same thing as if user presses login button - only used when the screen finishes launching for automated login with correct credentials
    func checkLogin(_ login:String, _ password:String) {
        
        if accounts.validatedAccount(login, password) {
            let navController = self.storyboard!.instantiateViewController(withIdentifier: "NavController")
            
            self.present(navController, animated:true, completion: nil)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
