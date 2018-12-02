//
//  CrimeAPIManager.swift
//  neighborhoodAwareness
//
//  Created by Luis Mendez on 11/19/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import Foundation

class CrimeAPIManager {
    
    //static let crimesURL = "https://data.cityofnewyork.us/resource/5jvd-shfj.json"
    var session: URLSession
    
    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    //func getMovies(urlString: String,completion: @escaping ([Crime]?, Error?) -> ()) {
    func getCrimes(url: String, completion: @escaping ([Crime]?, Error?) -> ()) {
        print("error: \(url)")
        let urlString = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        let url = URL(string: urlString!)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil, error)
                
            } else if let response = response as? HTTPURLResponse,
                response.statusCode == 200, let data = data {
                
                print("data: \(data)")
                var dataDictionary: [[String: Any]]?
                do {
                    dataDictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : Any]]
                    
                    //print(dataDictionary as Any)
                    
                } catch let parseError {
                    
                    print(parseError.localizedDescription)
                    return
                }
                
                let crimeDictionaries = dataDictionary
                
                let crimes = Crime.crimes(dictionaries: crimeDictionaries ?? [[:]])//its class function
                
                completion(crimes, nil)//all good, send this to where this func was called
            }//else if
        }
        task.resume()
    }
    
    func getBoundaries(completion: @escaping ([Crime]?, Error?) -> ()) {
        
        //https://nominatim.openstreetmap.org/search.php?q=queens%2C+New+York+&polygon_geojson=1&viewbox=
        let url = URL(string: "https://nominatim.openstreetmap.org/search.php?q=Queens+New+York&polygon_geojson=1&format=json")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in
            
            if let data = data {
                let dataArray = try! JSONSerialization.jsonObject(with: data, options: []) as! NSArray
                print(dataArray)
                let dataDictionary = dataArray[0] as! [String: Any]
                print("*** \(dataDictionary)")
                let boundingBox = dataDictionary["boundingbox"] as! NSArray
                let geoJSON = dataDictionary["geojson"] as! [String: Any]
                print( "bounding " ,boundingBox)
                print("geojson " ,geoJSON)
                let coord = geoJSON["coordinates"] as! NSArray
                let realCoord = coord[0] as! NSArray
                for coo in realCoord {
                    print("hello \(coo)")
                }
                
            } else {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

