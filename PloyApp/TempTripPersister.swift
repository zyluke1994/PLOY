//
//  TempTripPersister.swift
//  Project2_Alex_Mai
//
//  Created by Alex Mai on 11/25/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class TempTripPersister: NSObject {
    static let TempTripArchiveURL: NSURL = {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent("temptrip.archive") as NSURL
    }()
    
    class func getTempTrip() -> TempTrip {
        if let tempTrip = NSKeyedUnarchiver.unarchiveObject(withFile: TempTripArchiveURL.path!) as? TempTrip {
            return tempTrip
        }
        else {
            return TempTrip()
        }
    }
    
    class func setTempTrip(_ tempTrip: TempTrip) -> Bool {
        return NSKeyedArchiver.archiveRootObject(tempTrip, toFile: TempTripArchiveURL.path!)
    }
}
