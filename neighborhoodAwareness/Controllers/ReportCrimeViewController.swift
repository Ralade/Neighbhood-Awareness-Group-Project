//
//  ReportCrimeViewController.swift
//  neighborhoodAwareness
//
//  Created by Kun Huang on 11/26/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import UIKit

protocol ReportCrimeDelegate: class {
    func didReportCrime(report: String)
}

class ReportCrimeViewController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var reportCrimeBox: UITextView!
    let imagePicker = UIImagePickerController()
    weak var reportCrimeDelegate: ReportCrimeDelegate?
    var takenPicture: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reportCrimeBox.delegate = self

        reportCrimeBox.text = "Crime description.."
        reportCrimeBox.textColor = UIColor.lightGray
    }
    
    @IBAction func reportCrime(_ sender: UIButton) {
        
        reportCrimeDelegate!.didReportCrime(report: reportCrimeBox.text)
        dismiss(animated: true, completion: nil)
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
    
    @IBAction func attachPictureOrVideo(_ sender: UIButton) {
        getPicture()
    }
    func getPicture() {
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePicker.sourceType = .camera
        } else {
            imagePicker.sourceType = .photoLibrary
        }
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            takenPicture = image
        }
        imagePicker.dismiss(animated: true, completion: nil)
        
        var attString: NSMutableAttributedString!
        attString = NSMutableAttributedString(attributedString: reportCrimeBox!.attributedText)
        let textAttach = NSTextAttachment()
        textAttach.image = takenPicture
        
        let oldWidth = textAttach.image!.size.width;
        
        let scaleFactor = oldWidth / (reportCrimeBox.frame.size.width - 10);
        textAttach.image = UIImage(cgImage: (textAttach.image?.cgImage)!, scale: scaleFactor, orientation: .up)
        
        let attStringWithImage = NSAttributedString(attachment: textAttach)
        
        attString.append(attStringWithImage)
        reportCrimeBox.attributedText = attString
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
