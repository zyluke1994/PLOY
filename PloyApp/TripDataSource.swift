//
//  TripDataSource.swift
//  Project3_Alex_Mai
//
//  Created by Alex Mai on 12/8/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit
import CoreData

class TripDataSource: NSObject {
    var trips: [Trip]
    
    override init() {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            let managedContext = delegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<Trip>(entityName: "Trip")
            
            do {
                trips = try managedContext.fetch(fetchRequest)
            }
            catch let error as NSError {
                print("Failed to load persistent data. \(error), \(error.userInfo)")
                trips = [Trip]()
            }
        }
        else {
            trips = [Trip]()
        }
        
        super.init()
    }
    
    
    //
    // MARK: entree management (creation and persistence)
    //
    
    func getUserTrips() -> [Trip]{
        let login = AccountDataSource.whoAmI
        
        var userTrips = [Trip]()
        
        for trip in trips {
            if trip.login == login {
                userTrips.append(trip)
            }
        }
        
        return userTrips
        
    }
    
    func addPlannedTrip() -> Bool {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Trip", in: managedContext)!
        let destinationEntity = NSEntityDescription.entity(forEntityName: "Destination", in: managedContext)!

        
        let presetDestinations = ["Rochester Airport (ROC)", "Times Square", "Empire State Building", "High Line", "Intrepid Museum", "World Trade Center", "Chinatown"]
        let latitudes = [43.1225, 40.7589, 40.7484, 40.7480, 40.7644, 40.7130, 40.7158]
        let longitudes = [-77.6666, -73.9851, -73.9857, -74.0048, -73.9993, -74.0132, -73.9970]
        
        let trip = Trip(entity: entity, insertInto: managedContext)
        trip.departLocation = "Rochester, NY"
        trip.arrivalLocation = "New York, NY"
        trip.departureDate = "12-10-2016"
        trip.returnDate = "12-31-2016"
        trip.numTravelers = "2"
        trip.travelerNationality = "American"
        trip.budget = "10000"
        trip.ofAge = true
        trip.disabilities = false
        trip.purpose = "For fun"
        trip.status = "Active"
        trip.login = AccountDataSource.whoAmI
        
        let mutableSetcopy: NSMutableOrderedSet = trip.destinations?.mutableCopy() as! NSMutableOrderedSet
        
        for i in 0..<presetDestinations.count {
            let destination = Destination(entity: destinationEntity, insertInto: managedContext)
            destination.place = presetDestinations[i]
            destination.latittude = latitudes[i]
            destination.longitude = longitudes[i]
            mutableSetcopy.add(destination)
            
        }
        
        trip.destinations = mutableSetcopy.copy() as? NSOrderedSet
        
//        let arrayRepresentation = trip.destinations?.array as! [Destination]
//        for destination in arrayRepresentation {
//            print(destination.place!)
//        }
        
        
        do {
            try managedContext.save()
            trips.append(trip)
            return true
        }
        catch let error as NSError {
            print("Failed to save Trip.  \(error), \(error.userInfo)")
            return false
        }
        
        
    }
    
    func newTrip(_ departLocationText:String , _ arrivalLocationText:String, _ departureDateText:String, _ returnDateText:String, _ numTravelersText:String, _ travelerNationalityText:String, _ budgetText:String, _ ofAge:Bool, _ disabilities:Bool, _ purposeText:String, _ statusText:String) -> Bool {
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return false
        }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Trip", in: managedContext)!
        
        //similar to insert in sql language
        let trip = Trip(entity: entity, insertInto: managedContext)
        trip.departLocation = departLocationText
        trip.arrivalLocation = arrivalLocationText
        trip.departureDate = departureDateText
        trip.returnDate = returnDateText
        trip.numTravelers = numTravelersText
        trip.travelerNationality = travelerNationalityText
        trip.budget = budgetText
        trip.ofAge = ofAge
        trip.disabilities = disabilities
        trip.purpose = purposeText
        trip.status = statusText
        trip.login = AccountDataSource.whoAmI
        trip.leg = 0
        trip.destinations = NSOrderedSet()
        
        
        do {
            try managedContext.save()
            trips.append(trip)
            return true
        }
        catch let error as NSError {
            print("Failed to save Trip.  \(error), \(error.userInfo)")
            return false
        }
    }
    
    func updateLeg(trip: Trip, leg: Int16) -> Int16{
        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
            return 0
        }
        
        let managedContext = delegate.persistentContainer.viewContext
        
        trip.leg = leg
        
        do {
            try managedContext.save()
            return trip.leg
        }
        catch let error as NSError {
            print("Failed to save Trip.  \(error), \(error.userInfo)")
            return 0
        }
        
        
    }
    
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
    
    func getTripDestinations(trip: Trip) -> [String] {
        
        var destinationsStringArray = [String]()
        
        if let destinations = trip.destinations {
    
            let destinationsArray: [Destination] = destinations.array as! [Destination]

            for destination in destinationsArray {
                if let thePlace: String = destination.place {
                    destinationsStringArray.append(thePlace)

                }
            }
    
        } //end if-let
        
        return destinationsStringArray
    
    }
    
    //to pass longitude and latitude
    func getTripDestinationsAsDestinations(trip: Trip) -> [Destination] {
        
        var destinationsArray: [Destination] = [Destination]()
        
        if let destinations = trip.destinations {
            
            destinationsArray = destinations.array as! [Destination]
        }
        
        return destinationsArray
    }
    
    
}
