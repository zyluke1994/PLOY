//
//  NearbySearchFetcher.swift
//  Project3_Alex_Mai
//
//  Created by Alex Mai on 12/15/16.
//  Copyright © 2016 Mobile Application Development. All rights reserved.
//

import Foundation

enum NearbySearchError: Error {
    case InvalidJSONError
}

enum NearbySearchResult {
    case NearbySearchSuccess(PlaceID)
    case NearbySearchFailure(Error)
}

class NearbySearchFetcher {
    private static let baseUrl = "https://maps.googleapis.com/maps/api/place/nearbysearch/json"
    
    let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    func fetchNearbySearch(for latitude: Double, longitude: Double, completion: @escaping (NearbySearchResult) -> Void) {

        let nearbySearchUrl = NearbySearchFetcher.getUrl(for: latitude, longitude: longitude)
        
        let request = URLRequest(url: nearbySearchUrl)
        
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            guard let searchResult = data else {
                completion(.NearbySearchFailure(error!))
                return
            }
            
            completion(NearbySearchFetcher.getNearbySearchInfo(from: searchResult))
        }
        
        task.resume()
        
    }
    
    //helper method
    private static func getUrl(for latitude: Double, longitude: Double) -> URL {
        
        
        var components = URLComponents(string: baseUrl)!
        
        //set up query items
        var queryItems = [URLQueryItem]()
        
        //location
        queryItems.append(URLQueryItem(name: "location", value: "\(latitude),\(longitude)"))
        //radius
        queryItems.append(URLQueryItem(name: "radius", value: "50"))
        //type
        queryItems.append(URLQueryItem(name: "type", value: "point_of_interest"))
        //key
        queryItems.append(URLQueryItem(name: "key", value: "AIzaSyD1rWn9m3sSj3nWUVRBCFFFucavvNrp9bk"))
        
        components.queryItems = queryItems
        
        //create and log URL
        return components.url!
        
    }
    
    //helper method 2 to parse JSON
    private static func getNearbySearchInfo(from json: Data) -> NearbySearchResult {
        
        do {
            let jsonObject: Any = try JSONSerialization.jsonObject(with: json, options: [])
            
            guard let jsonDict = jsonObject as? [String:AnyObject],
                let results = jsonDict["results"] as? [[String:AnyObject]] else {
                    return .NearbySearchFailure(NearbySearchError.InvalidJSONError)
            }
            
            let firstResult = results[0] as [String:AnyObject]
            
            
            let placeID = PlaceID(id: firstResult["place_id"] as? String)
            
            
            return .NearbySearchSuccess(placeID)
        }
        catch let error {
            return .NearbySearchFailure(error)
        }
    }
}
