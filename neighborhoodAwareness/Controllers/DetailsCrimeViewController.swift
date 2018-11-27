//
//  DetailsCrimeViewController.swift
//  neighborhoodAwareness
//
//  Created by Kun Huang on 11/26/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import UIKit

class DetailsCrimeViewController: UIViewController {

    @IBOutlet weak var crimeOffenseLabel: UILabel!
    @IBOutlet weak var boroughLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var jurisdictionLabel: UILabel!
    
    var crimeDetails: Crime?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        crimeOffenseLabel.text = crimeDetails?.crime
        boroughLabel.text = crimeDetails?.borough
        dateLabel.text = crimeDetails?.date
        jurisdictionLabel.text = crimeDetails?.jurisdiction
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
