//
//  ReportCrimeViewController.swift
//  neighborhoodAwareness
//
//  Created by Kun Huang on 11/26/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import UIKit

class ReportCrimeViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var reportCrimeBox: UITextView!
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportCrimeBox.delegate = self
        imagePicker.delegate = self

        reportCrimeBox.text = "Crime description.."
        reportCrimeBox.textColor = UIColor.lightGray
    }
    
    @IBAction func reportCrime(_ sender: UIButton) {
        
    }
    
    @IBAction func cancelReport(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
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
