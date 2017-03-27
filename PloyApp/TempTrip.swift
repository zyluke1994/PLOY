//
//  TempTrip.swift
//  Project2_Alex_Mai
//
//  Created by Alex Mai on 11/24/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TempTrip: NSObject, NSCoding {
    static let aDepartLocationKey = "aDepartLocation"
    static let aArrivalLocationKey = "aArrival"
    static let aDepartureDateKey = "aDepartureDate"
    static let aReturnDateKey = "aReturnDate"
    static let aNumTravelersKey = "aNumTravelers"
    static let aTravelerNationalityKey = "aTravelerNationality"
    static let aBudgetKey = "aBudget"
    static let aOfAgeKey = "aOfAge"
    static let aDisabilitiesKey = "aDisabilities"
    static let aPurposeKey = "aPurpose"
    
    var departLocationText:String , arrivalLocationText:String, departureDateText:String, returnDateText:String, numTravelersText:String, travelerNationalityText:String, budgetText:String, ofAge:Bool, disabilities:Bool, purposeText:String
    
    override init() {
        departLocationText = ""
        arrivalLocationText = ""
        departureDateText = ""
        returnDateText = ""
        numTravelersText = ""
        travelerNationalityText = ""
        budgetText = ""
        ofAge = true
        disabilities = false
        purposeText = ""
    }
    
    //required protocols
    func encode(with aCoder: NSCoder) {
        aCoder.encode(departLocationText, forKey: TempTrip.aDepartLocationKey)
        aCoder.encode(arrivalLocationText, forKey: TempTrip.aArrivalLocationKey)
        aCoder.encode(departureDateText, forKey: TempTrip.aDepartureDateKey)
        aCoder.encode(returnDateText, forKey: TempTrip.aReturnDateKey)
        aCoder.encode(numTravelersText, forKey: TempTrip.aNumTravelersKey)
        aCoder.encode(travelerNationalityText, forKey: TempTrip.aTravelerNationalityKey)
        aCoder.encode(budgetText, forKey: TempTrip.aBudgetKey)
        aCoder.encode(ofAge, forKey: TempTrip.aOfAgeKey)
        aCoder.encode(disabilities, forKey: TempTrip.aDisabilitiesKey)
        aCoder.encode(purposeText, forKey: TempTrip.aPurposeKey)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        departLocationText = aDecoder.decodeObject(forKey: TempTrip.aDepartLocationKey) as! String
        arrivalLocationText = aDecoder.decodeObject(forKey: TempTrip.aArrivalLocationKey) as! String
        departureDateText = aDecoder.decodeObject(forKey: TempTrip.aDepartureDateKey) as! String
        returnDateText = aDecoder.decodeObject(forKey: TempTrip.aReturnDateKey) as! String
        numTravelersText = aDecoder.decodeObject(forKey: TempTrip.aNumTravelersKey) as! String
        travelerNationalityText = aDecoder.decodeObject(forKey: TempTrip.aTravelerNationalityKey) as! String
        budgetText = aDecoder.decodeObject(forKey: TempTrip.aBudgetKey) as! String
        ofAge = aDecoder.decodeBool(forKey: TempTrip.aOfAgeKey)
        disabilities = aDecoder.decodeBool(forKey: TempTrip.aDisabilitiesKey)
        purposeText = aDecoder.decodeObject(forKey: TempTrip.aPurposeKey) as! String
    }
    
    // now create a TempTrip Persister
}
