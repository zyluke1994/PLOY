//
//  PlaceDetailFetcher.swift
//  Project3_Alex_Mai
//
//  Created by Alex Mai on 12/10/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import Foundation

enum PlaceDetailError: Error {
    case InvalidJSONError
}

enum PlaceDetailResult {
    case PlaceDetailSuccess(PlaceDetail)
    case PlaceDetailFailure(Error)
}

class PlaceDetailFetcher {
    private static let baseUrl = "https://maps.googleapis.com/maps/api/place/details/json"
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchPlaceDetails(for placeID: String, completion: @escaping (PlaceDetailResult) -> Void) {
        
        let placeDetailsUrl = PlaceDetailFetcher.getUrl(for: placeID)
        
        let request = URLRequest(url: placeDetailsUrl)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard let searchResult = data else {
                completion(.PlaceDetailFailure(error!))
                return
            }
            
            completion(PlaceDetailFetcher.getPlaceDetailInfo(from: searchResult))
        }
        
        task.resume()
        
    }
    
    //helper method
    private static func getUrl(for placeID: String) -> URL {
        
        var components = URLComponents(string: baseUrl)!
        
        //set up query items
        var queryItems = [URLQueryItem]()
        
        //placeID
        queryItems.append(URLQueryItem(name: "placeid", value: placeID))
        //key
        queryItems.append(URLQueryItem(name: "key", value: "AIzaSyD1rWn9m3sSj3nWUVRBCFFFucavvNrp9bk"))
        
        components.queryItems = queryItems
        
        //create and log URL
        return components.url!
    
    }
    
    //helper method 2 to parse JSON
    private static func getPlaceDetailInfo(from json: Data) -> PlaceDetailResult {
        
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: json, options: [])
            
            guard let jsonDict = jsonObject as? [String:AnyObject],
            let result = jsonDict["result"] as? [String:AnyObject] else {
                    return .PlaceDetailFailure(PlaceDetailError.InvalidJSONError)
            }
            
            //this json key is optional by google
            let open_hours = result["open_hours"] as? [String:AnyObject]
            
            let placeDetail = PlaceDetail(formattedAddress: result["formatted_address"] as? String, name: result["name"] as? String, open_now: open_hours?["open_now"] as? Bool, rating: result["rating"] as? Double, website: result["website"] as? String)
            
            return .PlaceDetailSuccess(placeDetail)
        }
        catch let error {
            return .PlaceDetailFailure(error)
        }
    }
    
    
}
