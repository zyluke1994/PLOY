//
//  ImagePersister.swift
//  Project2_Alex_Mai
//
//  Created by Alex Mai on 11/24/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import UIKit

class ImagePersister: NSObject {
    
    class func saveImage(_ image: UIImage, forEmail email: String) {
        let imageURL = ImagePersister.imageURLForEmail(email)
        if let data = UIImageJPEGRepresentation(image, 0.5) {
            do {
                try data.write(to: imageURL, options: .atomic)
            }
            catch {
                print("could not save your photo")
            }
        }
    }
    
    class func getImage(forEmail email: String) -> UIImage? {
        let imageURL = ImagePersister.imageURLForEmail(email)
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path) else {
            return nil
        }
        
        return imageFromDisk
    }
    
    class func imageURLForEmail(_ key: String) -> URL {
        let documentsDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentDirectory = documentsDirectories.first!
        return documentDirectory.appendingPathComponent(key)
    }
    
}
