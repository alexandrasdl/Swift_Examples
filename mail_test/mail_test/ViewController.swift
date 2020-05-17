//
//  ViewController.swift
//  mail_test
//
//  Created by Alexandra Lopes on 30/01/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMailComposeViewControllerDelegate {
    
    var employeeArray:[Dictionary<String, AnyObject>] =  Array()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 1...10 {
            var dct = Dictionary<String, AnyObject>()
            dct.updateValue(i as AnyObject, forKey: "EmpID")
            dct.updateValue("NameForEmplyee id = \(i)" as AnyObject, forKey: "EmpName")
            employeeArray.append(dct)
        }
        
        print(employeeArray)
    }

    @IBAction func sendEmail(_ sender: Any) {
        let mailComposerViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerViewController,animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
    
    func configureMailController()-> MFMailComposeViewController{
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["asd.lopes@campus.fct.unl.pt"])
        mailComposerVC.setSubject("Hello")
        mailComposerVC.setMessageBody("hi, how are u?", isHTML: false)

        print("ok")
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        let filePath2 = url.path
        let fileManager = FileManager.default
        print(try! fileManager.contentsOfDirectory(atPath: filePath2!))
        let fileURL = url.appendingPathComponent("CSVRec.csv")
        print(fileURL)
        print("ok")
        
        if let fileData = NSData(contentsOf: fileURL!) {
            mailComposerVC.addAttachmentData(fileData as Data, mimeType: "text/txt", fileName: "CSVRec.csv")
        }
        
        return mailComposerVC
    }
    
    func showMailError(){
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "ok", style: .default, handler: nil)
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert,animated: true, completion: nil)
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
// create csv
    @IBAction func csv_btn(_ sender: Any) {
        createCSV(from: employeeArray)
        print(NSHomeDirectory())
    }

    func createCSV(from recArray:[Dictionary<String, AnyObject>]) {
    var csvString = "\("Employee ID"),\("Employee Name")\n\n"
    for dct in recArray {
        csvString = csvString.appending("\(String(describing: dct["EmpID"]!)) ,\(String(describing: dct["EmpName"]!))\n")
    }
    
    let fileManager = FileManager.default
        
    do {
        let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
        let fileURL = path.appendingPathComponent("CSVRec.csv")
        try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        print("boa")
        print(fileURL)
    } catch {
        print("error creating file")
    }

}
}
