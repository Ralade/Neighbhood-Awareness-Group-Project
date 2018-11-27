//
//  ReportCrimeViewController.swift
//  neighborhoodAwareness
//
//  Created by Kun Huang on 11/26/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import UIKit

class ReportCrimeViewController: UIViewController {

    
    @IBOutlet weak var reportCrimeBox: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func reportCrime(_ sender: UIButton) {
        
    }
    
    @IBAction func cancelReport(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
