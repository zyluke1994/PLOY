//
//  FourthViewController.swift
//  Project2_Alex_Mai
//
//  Created by Alex Mai on 11/25/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class FourthViewController: UIViewController {
    
    var cellClicked: Int!
    var tripsDataSource: TripDataSource!
    var userTrips: [Trip]?
    
    //fetch the URL from google search result
    var imageURLFetcher: ImageURLFetcher!
    var imageFetcher: ImageFetcher!
    
    @IBOutlet weak var destinationLabel: UILabel!
    @IBOutlet weak var destinationImageView: UIImageView!
    @IBOutlet weak var departFromLabel: UILabel!
    @IBOutlet weak var departureDateLabel: UILabel!
    @IBOutlet weak var returnDateLabel: UILabel!
    @IBOutlet weak var numTravelersLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tripsDataSource = TripDataSource()
        userTrips = tripsDataSource.getUserTrips()
        
        imageURLFetcher = ImageURLFetcher()
        imageFetcher = ImageFetcher()
        
        if let trips = userTrips {
            let thisTrip = trips[cellClicked]
            
            destinationLabel.text = thisTrip.arrivalLocation
            departFromLabel.text = String(format: NSLocalizedString("Depart From: %@", comment: "departFromLabel"), thisTrip.departLocation!)
            departureDateLabel.text = String(format: NSLocalizedString("Depart Date: %@", comment: "departureDateLabel"), thisTrip.departureDate!)
            returnDateLabel.text = String(format: NSLocalizedString("Return Date: %@", comment: "returnDateLabel"), thisTrip.returnDate!)
            numTravelersLabel.text = String(format: NSLocalizedString("Num Travelers: %@", comment: "numTravelersLabel"), thisTrip.numTravelers!)
            purposeLabel.text = String(format: NSLocalizedString("Purpose of Trip: %@", comment: "purposeLabel"), thisTrip.purpose!)
            statusLabel.text = String(format: NSLocalizedString("Status: %@", comment: "statusLabel"), thisTrip.status!)
            
            //if the trip has been approved, then 
            if (thisTrip.status == "approved") {
                statusLabel.textColor = UIColor.green
            }
            
            //fetch for a URL
            imageURLFetcher.fetchURLImage(for: thisTrip.arrivalLocation!) {
                (ImageURLResult) -> Void in
                
                switch(ImageURLResult) {
                case let .ImageURLSuccess(imageURL):
                    //if imageURL is fetched then fetch it from the website
                    self.imageFetcher.fetchImage(url: imageURL.imageString!) {
                        (fetchResult) -> Void in
                        switch(fetchResult) {
                        case let .ImageSuccess(image):
                            OperationQueue.main.addOperation() {
                                self.destinationImageView.image = image
                            }
                        case let .ImageFailure(error):
                            OperationQueue.main.addOperation {
                                self.destinationImageView.image = #imageLiteral(resourceName: "cruise")
                            }
                            print("error: \(error)")
                        }
                    }
                case let .ImageURLFailure(error):
                    print("error: \(error)")
                }
            } //close .fetchURLImage
            
        } //close if-let trips
            
        
    } //viewDidLoad
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
}
