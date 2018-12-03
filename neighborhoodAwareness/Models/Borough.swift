//
//  Borough.swift
//  neighborhoodAwareness
//
//  Created by Kun Huang on 12/2/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import Foundation
import MapKit

class Borough {
    
    var boroughName: String?
    var boundaries:[CLLocationCoordinate2D] = []
    
    init(name: String, coordinates: NSArray) {
        self.boroughName = name
        
        for each in coordinates {
            let eachCoord = each as! NSArray
            let long = eachCoord[0] as! Double
            let lat = eachCoord[1] as! Double
            self.boundaries.append(CLLocationCoordinate2DMake(lat, long))
        }
    }
}
