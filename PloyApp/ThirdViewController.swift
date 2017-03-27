//
//  ThirdViewController.swift
//  Project1_Alex_Mai
//
//  Created by Alex Mai on 10/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit


//This class details the personal information of the user
class ThirdViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    var accounts:AccountDataSource!
    
    //MARK: Outlets
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var genderLabel: UILabel!
    @IBOutlet var ageLabel: UILabel!
    @IBOutlet var imageViewer: UIImageView!
    @IBOutlet var emergencyContact: UILabel!
    @IBOutlet weak var cameraItem: UIBarButtonItem!
    
    //MARK: Actions
    @IBAction func cameraButtonPressed(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
            picker.delegate = self
            present(picker, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func photolibraryButtonPressed(_ sender: AnyObject) {
        let picker = UIImagePickerController()

        picker.sourceType = .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        AccountDataSource.whoAmI = ""
        dismiss(animated: true, completion: nil)
    }
    
    // picker controller delegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let photo = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //save the photo - tie the unique ID from caption to the image, so link
        ImagePersister.saveImage(photo, forEmail: accounts.accounts[accounts.getAccountIndex(AccountDataSource.whoAmI)].email!)
        
        imageViewer.image = photo
        
        dismiss(animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        accounts = AccountDataSource()
        
        //if camera is unavailable, disable the camera button
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraItem.isEnabled = false
        }
        
        //autopopulate the user's information given login
        let whoamI = AccountDataSource.whoAmI
        nameLabel.text = accounts.accounts[accounts.getAccountIndex(whoamI)].name
        emailLabel.text = accounts.accounts[accounts.getAccountIndex(whoamI)].email
        genderLabel.text = accounts.accounts[accounts.getAccountIndex(whoamI)].gender
        ageLabel.text = (String) (accounts.accounts[accounts.getAccountIndex(whoamI)].age)
        
        //if the image were saved, then persist the last saved image, otherwise display its default associated with the account
        if let img = ImagePersister.getImage(forEmail: accounts.accounts[accounts.getAccountIndex(whoamI)].email!) {
            imageViewer.image = img
        }
        else {
            let img = accounts.accounts[accounts.getAccountIndex(whoamI)].image
            
            imageViewer.image = UIImage(named: img!)
        }
        
        emergencyContact.text = accounts.accounts[accounts.getAccountIndex(whoamI)].emergencyContact
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
