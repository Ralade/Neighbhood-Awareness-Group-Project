//
//  SearchViewController.swift
//  neighborhoodAwareness
//
//  Created by Luis Mendez on 10/31/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import UIKit
import Alamofire

class SearchViewController: UIViewController {

    
    @IBOutlet weak var jurisdictionText: UITextField!
    @IBOutlet weak var boroughText: UITextField!
    @IBOutlet weak var crimeText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    
    var crimes: [Crime] = []//contains all or filter movies with searchBar
    override func viewDidLoad() {
        super.viewDidLoad()

        self.revealViewController().rearViewRevealWidth = self.view.frame.size.width - 60
    }
    
    @IBAction func fetchData(_ sender: Any) {
        
        //$limit=100&$offset=100
        var crimesURL = "https://data.cityofnewyork.us/resource/5jvd-shfj.json?"
        //var crimesURL = "https://data.cityofnewyork.us/resource/7x9x-zpz6.json?"
        print("url: \(crimesURL)")
        //juris_desc=AMTRACK
        if jurisdictionText.text != "" {
            crimesURL += "&juris_desc=" +
                 jurisdictionText.text!
        }
        
        //boro_nm=BRONX
        if boroughText.text! != "" {
            crimesURL += "&boro_nm=" + boroughText.text!
        }
        
        //ofns_desc=ABORTION
        if crimeText.text! != "" {
            crimesURL += "&ofns_desc=" + crimeText.text!
        }
        
        //cmplnt_fr_dt=2016-06-22T00:00:00
        if dateText.text! != "" {
            crimesURL += "&cmplnt_fr_dt=" + dateText.text!
        }
        
        CrimeAPIManager().getCrimes(url: crimesURL) { (crimes: [Crime]?, error: Error?) in
            
            //if array of crimes was return then put it into this class crimes array to use it
            if let crimes = crimes {
                self.crimes = crimes
                print("my json")
                print(Crime.printAllCrimes(crimes: crimes))
                print("Crimes count: \(crimes.count)")
            } else {
                
                print("could not download crimes!")
            }
        }
    }
    
}
