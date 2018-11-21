//
//  Crime.swift
//  neighborhoodAwareness
//
//  Created by Luis Mendez on 11/19/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import Foundation

class Crime {
    
    var id: Int
    var jurisdiction: String
    var borough: String
    var crime: String
    var date: String
    var lon: Double
    var lat: Double
    
    init(dictionary: [String: Any]) {
        id = Int(dictionary["cmplnt_num"] as? String ?? "0") ?? 0
        jurisdiction = dictionary["juris_desc"] as? String ?? "No jurisdiction given"
        borough = dictionary["boro_nm"] as? String ?? "No borough given"
        crime = dictionary["ofns_desc"] as? String ?? "No crime given"
        date = dictionary["cmplnt_fr_dt"] as? String ?? "No date given"
        lon = Double(dictionary["longitude"] as? String ?? "0.0")  ?? 0.0
        lat = Double(dictionary["latitude"] as? String ?? "0.0")  ?? 0.0
    }
    
    class func crimes(dictionaries: [[String: Any]]) -> [Crime] {
        var crimes: [Crime] = []
        
        for dictionary in dictionaries {
            let crime = Crime(dictionary: dictionary)
            crimes.append(crime)
        }
        
        return crimes
    }
    
    class func printAllCrimes(crimes: [Crime]) -> [[String : Any]]{
        
        var delito: [String : Any] = [:]
        var delitos: [[String : Any]] = []
        
        for crime in crimes {
            delito["id"] = crime.id
            delito["crime"] = crime.crime
            delito["jurisdiction"] = crime.jurisdiction
            delito["borough"] = crime.borough
            delito["date"] = crime.date
            delito["lat"] = crime.lat
            delito["lon"] = crime.lon
            delitos.append(delito)
        }
        
        return delitos
    }
}
