//
//  DetailsCrimeViewController.swift
//  neighborhoodAwareness
//
//  Created by Kun Huang on 11/26/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import UIKit

class DetailsCrimeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var crimeOffenseLabel: UILabel!
    @IBOutlet weak var boroughLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var jurisdictionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var crimeDetails: Crime?
    var crimeDescription: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        crimeOffenseLabel.text = crimeDetails?.crime
        boroughLabel.text = crimeDetails?.borough
        dateLabel.text = crimeDetails?.date
        jurisdictionLabel.text = crimeDetails?.jurisdiction
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "reportCrime" {
            let destinationVC = segue.destination as! ReportCrimeViewController
            destinationVC.reportCrimeDelegate = self
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crimeDescription.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReportCrimeCell", for: indexPath) as! ReportCrimeCell
        
        cell.crimeDescriptionLabel.text = crimeDescription[indexPath.row]
        
        return cell
    }

}

extension DetailsCrimeViewController: ReportCrimeDelegate {
    func didReportCrime(report: String) {
        crimeDescription.append(report)
        print(crimeDescription.count)
        tableView.reloadData()
    }
}
