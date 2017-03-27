//
//  ImageFetcher.swift
//  Project3_Alex_Mai
//
//  Created by Alex Mai on 12/7/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import Foundation

enum ImageURLError: Error {
    case InvalidJSONError
}

enum ImageURLResult {
    case ImageURLSuccess(ImageURL)
    case ImageURLFailure(Error)
}

class ImageURLFetcher {
    private static let baseUrl = "https://www.googleapis.com/customsearch/v1"
    
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchURLImage(for location: String, completion: @escaping (ImageURLResult) -> Void) {
        let imageURL = ImageURLFetcher.getUrl(for: location)
        
        let request = URLRequest(url: imageURL)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard let searchResult = data else {
                completion(.ImageURLFailure(error!))
                return
            }
            
            completion(ImageURLFetcher.getURLImage(from: searchResult))
        }
        task.resume()
    }
    
    private static func getUrl(for location: String) -> URL {
        var components = URLComponents(string: baseUrl)!
        
        //set up query parameters
        var queryItems = [URLQueryItem]()
        
        //key
        queryItems.append(URLQueryItem(name: "key", value: "AIzaSyD1rWn9m3sSj3nWUVRBCFFFucavvNrp9bk"))
        //search engine id
        queryItems.append(URLQueryItem(name: "cx", value: "001002519830079391516:qwfbv_vxge0"))
        //location query
        queryItems.append(URLQueryItem(name: "q", value: location))
        //search type image
        queryItems.append(URLQueryItem(name: "searchType", value: "image"))
        //safe search on
        queryItems.append(URLQueryItem(name: "safe", value: "medium"))
        
        components.queryItems = queryItems
        
        //create and log URL
        return components.url!
    }
    
    private static func getURLImage(from json: Data) -> ImageURLResult {
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: json, options: [])
            
//            dump(jsonObject)
            
            guard let jsonDict = jsonObject as? [String:AnyObject],
                let items = jsonDict["items"] as? [[String:AnyObject]] else {
                    return .ImageURLFailure(ImageURLError.InvalidJSONError)
            }
            
            let firstItem = items[0] as [String:AnyObject]
            let imageLink = firstItem["link"]
            
//            dump(imageLink)
            
            let imageURL = ImageURL(imageString: imageLink as? String)
            
            return .ImageURLSuccess(imageURL)
            
        }
        catch let error {
            return .ImageURLFailure(error)
        }
    }
}
