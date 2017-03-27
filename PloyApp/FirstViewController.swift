//
//  FirstViewController.swift
//  Project1_Alex_Mai
//
//  Created by Alex Mai on 10/26/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

//This class is a form - user asks an agent to plan item for him/her
//Help for UIDatePicker from http://stackoverflow.com/questions/29678471/expanding-and-collapsing-uitableviewcells-with-datepicker
class FirstViewController: UITableViewController, UITextFieldDelegate {
    
    var tempTrip: TempTrip!
    var trips: TripDataSource!
    
    var departureDatePickerisVisible = false
    var returnDatePickerisVisible = false
  
    //MARK: Outlets
    @IBOutlet var departLocation: UITextField!
    @IBOutlet var arrivalLocation: UITextField!
    @IBOutlet weak var departureDatePickerOutlet: UIDatePicker!
    @IBOutlet weak var returnDatePickerOutlet: UIDatePicker!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    @IBOutlet var numTravelers: UITextField!
    @IBOutlet var travelerNationality: UITextField!
    @IBOutlet var budget: UITextField!
    @IBOutlet var ofAge: UISwitch!
    @IBOutlet var disabilities: UISwitch!
    @IBOutlet var purpose: UITextField!
    
    //MARK: Actions
    @IBAction func departLocationValueChanged(_ sender: Any) {
        if let departLocationString = departLocation.text {
            tempTrip.departLocationText = departLocationString
        }
    }
    @IBAction func arrivalLocationValueChanged(_ sender: Any) {
        if let arrivalLocationString = arrivalLocation.text {
            tempTrip.arrivalLocationText = arrivalLocationString
        }
    }
    @IBAction func departureDatePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let customDate = dateFormatter.string(from: departureDatePickerOutlet.date)
        
        departureDateLabel.text = customDate
        tempTrip.departureDateText = customDate
    }
    @IBAction func returnDatePicker(_ sender: Any) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        let customDate = dateFormatter.string(from: returnDatePickerOutlet.date)
        
        returnDateLabel.text = customDate
        tempTrip.returnDateText = customDate
    }
    @IBAction func numTravelersValueChanged(_ sender: Any) {
        if let numTravelersString = numTravelers.text {
            tempTrip.numTravelersText = numTravelersString
        }
    }
    @IBAction func nationalitiesValueChanged(_ sender: Any) {
        if let nationalitiesString = travelerNationality.text {
            tempTrip.travelerNationalityText = nationalitiesString
        }
    }
    @IBAction func budgetValueChanged(_ sender: Any) {
        if let budgetString = budget.text {
            tempTrip.budgetText = budgetString
        }
    }
    @IBAction func ofAgeValueChanged(_ sender: Any) {
        tempTrip.ofAge = ofAge.isOn
    }
    @IBAction func disabilitiesValueChanged(_ sender: Any) {
        tempTrip.disabilities = disabilities.isOn
    }
    @IBAction func purposeValueChanged(_ sender: Any) {
        if let purposeString = purpose.text {
            tempTrip.purposeText = purposeString
        }
    }
    
    @IBAction func submitPressed(sender: UIButton) {
        
        //resign first responder whichever is active
        view.endEditing(true)
        
        //takes all valid input and add to tripmanager
        if let departLocationText = departLocation.text,
            let arrivalLocationText = arrivalLocation.text,
            let departureDateText = departureDateLabel.text,
            let returnDateText = returnDateLabel.text,
            let numTravelersText = numTravelers.text,
            let travelerNationalityText = travelerNationality.text,
            let budgetText = budget.text,
            let purposeText = purpose.text {
            
            //Check things to see if they are valid
            if (departLocationText.isEmpty || arrivalLocationText.isEmpty || departureDateText.isEmpty || returnDateText.isEmpty || numTravelersText.isEmpty || travelerNationalityText.isEmpty || budgetText.isEmpty || purposeText.isEmpty) {
                warnUser(NSLocalizedString("At least one of the fields is empty. Please go back and fix it.", comment: "One of the fields is empty."))
            }
            else if (!cityStateConforms(departLocationText)) {
                warnUser(NSLocalizedString("Your location must match 'City, State' format. Please go back and fix it.", comment: "Location must match City, State format"))
            }
            else if (!cityStateConforms(arrivalLocationText)) {
                warnUser(NSLocalizedString("Your location must match 'City, State' format. Please go back and fix it.", comment: "Location must match City, State format"))
            }
            else {
                //user-requested trips are pending a travel advisor's plan
                //add to data source and save
                
                print(trips.newTrip(departLocationText, arrivalLocationText, departureDateText, returnDateText, numTravelersText, travelerNationalityText, budgetText, ofAge.isOn, disabilities.isOn, purposeText, "pending"))

                
                //reset the text fields to be blank
                departLocation.text = nil
                arrivalLocation.text = nil
                departureDateLabel.text = nil
                returnDateLabel.text = nil
                numTravelers.text = nil
                travelerNationality.text = nil
                budget.text = nil
                ofAge.isOn = false
                disabilities.isOn = false
                purpose.text = nil
                
                confirmButtonPressed()

            }
            
        }
        
    }

    //delegates used for hiding and showing the cell when dates are selected
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 44.0
        
        if (indexPath.row == 3) {
            height = departureDatePickerisVisible ? 193.0 : 0.0
        }
        if (indexPath.row == 5) {
            height = returnDatePickerisVisible ? 193.0 : 0.0
        }
        return height
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 2) {
            //if departure is selected, then it should not show return date
            hideDatePickerCell(returnDatePickerOutlet)
            
            if (!departureDatePickerisVisible) {
                showDatePickerCell(departureDatePickerOutlet)
            }
            else {
                hideDatePickerCell(departureDatePickerOutlet)
            }
        }
        else if (indexPath.row == 4) {
            //if return date is selected, then it should not show departure date
            hideDatePickerCell(departureDatePickerOutlet)
            
            if(!returnDatePickerisVisible) {
                showDatePickerCell(returnDatePickerOutlet)
            }
            else {
                hideDatePickerCell(returnDatePickerOutlet)
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //helper function 1
    func showDatePickerCell(_ picker: UIDatePicker) {
        if (picker == departureDatePickerOutlet) {
            departureDatePickerisVisible = true
            
        }
        else if (picker == returnDatePickerOutlet) {
            returnDatePickerisVisible = true
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
        picker.isHidden = false
        picker.alpha = 0.0
        
        UIView.animate(withDuration: 0.25, animations: { () -> Void in
            picker.alpha = 1.0})
    }
    
    //helper function 2
    func hideDatePickerCell(_ picker: UIDatePicker) {
        if (picker == departureDatePickerOutlet) {
            departureDatePickerisVisible = false
        }
        else if (picker == returnDatePickerOutlet) {
            returnDatePickerisVisible = false
        }
        
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        
        UIView.animate(withDuration: 0.25,
                       animations: { () -> Void in
                        picker.alpha = 0.0},
                       completion: { (bool) -> Void in
                        picker.isHidden = true})
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        
        return true
    }
    
    //confirm button pressed
    func confirmButtonPressed() {
        let title = NSLocalizedString("info-captured", comment: "Information captured!")
        let message = NSLocalizedString("info-submitted", comment: "The information you entered has been submitted to our team. One of our advisors will reach out to you for more information.")
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let confirmAction = UIAlertAction(title: NSLocalizedString("ok", comment: "Ok"), style: .default, handler: nil)
        ac.addAction(confirmAction)

        
        present(ac, animated: true, completion: nil)
    }
    
    //warn user of invalid input
    func warnUser(_ warnMessage: String) {
        let title = NSLocalizedString("Warning", comment: "Warning!")
        let message = warnMessage
//        let message = NSLocalizedString("something-wrong", comment: warnMessage)
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirmAction = UIAlertAction(title: NSLocalizedString("ok", comment: "Ok"), style: .default, handler: nil)
        ac.addAction(confirmAction)
        
        
        present(ac, animated: true, completion: nil)
    }
    
    //make sure Departure Location and Arrival Location conform to City, State template
    func cityStateConforms(_ location: String) -> Bool {
        let characters = location.components(separatedBy: " ")
        
        print(characters.count)
        
        if (characters.count < 2) {
            return false
        }
        else if (characters.count < 4) {
            if(characters.count == 2) {
                if(!characters[0].contains(",")) {
                    return false
                }
            }
            if(characters.count == 3) {
                if(!characters[1].contains(",")) {
                    return false
                }
            }
        }
        else if(characters.count > 3) {
            return false
        }
        
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        departureDatePickerOutlet.isHidden = true
        departureDatePickerOutlet.translatesAutoresizingMaskIntoConstraints = false
        

        returnDatePickerOutlet.isHidden = true
        returnDatePickerOutlet.translatesAutoresizingMaskIntoConstraints = false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //initialize core data
        trips = TripDataSource()
        
        //set title of nav
        navigationItem.title = NSLocalizedString("Request a Plan", comment: "Request Plan nav title")
        
        //make initial label to blank
        departureDateLabel.text = ""
        returnDateLabel.text = ""
        
        //insets
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let insets = UIEdgeInsets(top: statusBarHeight, left: 0, bottom: 0, right: 0)
        
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        
        //Access app delegate to persist the form information
        let myDelegate = UIApplication.shared.delegate as! AppDelegate
        tempTrip = myDelegate.tempTripForm
        
        //load in data if it were previously saved in
        departLocation.text = tempTrip.departLocationText
        arrivalLocation.text = tempTrip.arrivalLocationText
        departureDateLabel.text = tempTrip.departureDateText
        returnDateLabel.text = tempTrip.returnDateText
        numTravelers.text = tempTrip.numTravelersText
        travelerNationality.text = tempTrip.travelerNationalityText
        budget.text = tempTrip.budgetText
        ofAge.isOn = tempTrip.ofAge
        disabilities.isOn = tempTrip.disabilities
        purpose.text = tempTrip.purposeText
        
        //set the minimum date to be today's date
        departureDatePickerOutlet.minimumDate = Date()
        returnDatePickerOutlet.minimumDate = Date()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

