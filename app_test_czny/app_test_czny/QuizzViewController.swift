//
//  QuizzViewController.swift
//  app_test_czny
//
//  Created by Alexandra Lopes on 12/03/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit
import MessageUI
import Foundation
import CoreMotion
import simd

struct SensorData {
    var time: [Double] = []
    var roll: [Double] = []
    var pitch: [Double] = []
    var yaw: [Double] = []
    var rotationRateX: [Double] = []
    var rotationRateY: [Double] = []
    var rotationRateZ: [Double] = []
    var userAccelerationX: [Double] = []
    var userAccelerationY: [Double] = []
    var userAccelerationZ: [Double] = []
    var magneticfieldX: [Double] = []
    var magneticfieldY: [Double] = []
    var magneticfieldZ: [Double] = []
}

class QuizzViewController: UIViewController, KeyboardDelegate,  MFMailComposeViewControllerDelegate {
    
    //text outlet
    
    @IBOutlet weak var textField: UITextField!
    //buttons outlet
    @IBOutlet weak var btn1: SenseButton!
    
    //view output
    var employeeArray: [Dictionary<String, AnyObject>] =  Array()
    
    var count: Int!
    var fileURL: URL!
    var data: SensorData! = SensorData()
    var motionManager: CMMotionManager? = CMMotionManager()
    
    func keyWasTapped(character: String) {
        textField.insertText(character)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // initialize custom keyboard
        let keyboardView = keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 200))
        
        keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped
    
        // replace system keyboard with custom keyboard
        textField.inputView = keyboardView
        
        count = 0
        
            //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

            //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
            //tap.cancelsTouchesInView = false

            view.addGestureRecognizer(tap)
        }

        //Calls this function when the tap is recognized.
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            view.endEditing(true)
        }
    
    @IBAction func btn1_action(_ sender: SenseButton) {
        print("funciona?")
    }
    
    @IBAction func start(_ sender: Any) {
        resetSensorData()
        startQueuedUpdates()
    }
    
    @IBAction func stop(_ sender: Any) {
        stopQueueUpdates()
        print(data!)
        send()
    }
    
     func send() {
        print("ok")
        for i in 0 ..< count  {
                var dct = Dictionary<String, AnyObject>()
                dct.updateValue(self.data.time[i] as AnyObject, forKey: "EmpID")
                dct.updateValue(self.data.userAccelerationX[i] as AnyObject, forKey: "EmpName")
                employeeArray.append(dct)
            }
            
            createCSV(from: data)
        
            let mailComposerViewController = configureMailController()
            if MFMailComposeViewController.canSendMail() {
                self.present(mailComposerViewController,animated: true, completion: nil)
            } else {
                showMailError()
            }
        }
    
    func createCSV(from data: SensorData) {
    var csvString = "\("TimeStamp"),\("acc_x"),\("acc_y"),\("acc_z"),\("gyro_x"),\("gyro_y"),\("gyro_z"),\("magn_x"),\("magn_y"),\("magn_z"),\("roll"),\("pitch"),\("yaw")\n\n"
    for i in 0 ..< count  {
        csvString = csvString.appending("\(String(describing: self.data.time[i])) ,\(String(describing: self.data.userAccelerationX[i])) ,\(String(describing: self.data.userAccelerationY[i])) ,\(String(describing: self.data.userAccelerationZ[i])) ,\(String(describing: self.data.rotationRateX[i])) ,\(String(describing: self.data.rotationRateY[i])) ,\(String(describing: self.data.rotationRateZ[i])) ,\(String(describing: self.data.magneticfieldX[i])) ,\(String(describing: self.data.magneticfieldY[i])) ,\(String(describing: self.data.magneticfieldZ[i])) ,\(String(describing: self.data.roll[i])) ,\(String(describing: self.data.pitch[i])) ,\(String(describing: self.data.yaw[i]))\n")
        }
        
        
        var csvButton = "\("Timestamp")\n"
        print(btn1.test())
        for j in btn1.test(){
            print(j)
            csvButton = csvButton.appending("\(String(describing: j))\n")
        }
        
    let fileManager = FileManager.default
        
    do {
        let path = try fileManager.url(for: .documentDirectory, in: .allDomainsMask, appropriateFor: nil, create: false)
        let fileURL = path.appendingPathComponent("CSVmotion.csv")
        try csvString.write(to: fileURL, atomically: true, encoding: .utf8)
        print("boa")
        print(fileURL)
        //create csv dos buttons
        let fileURL2 = path.appendingPathComponent("CSVbutton.csv")
        try csvButton.write(to: fileURL2, atomically: true, encoding: .utf8)
        print("boa")
        print("//////////////////")
        print(fileURL2)
        print("//////////////////")
    } catch {
        print("error creating file")
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
        
          let fileURL = url.appendingPathComponent("CSVmotion.csv")
          let fileURL2 = url.appendingPathComponent("CSVbutton.csv")
          print("//////////////////")
          print(fileURL2)
          print("//////////////////")
          if let fileData = NSData(contentsOf: fileURL!) {
              mailComposerVC.addAttachmentData(fileData as Data, mimeType: "text/txt", fileName: "CSVmotion.csv")
          }
        
          if let fileData2 = NSData(contentsOf: fileURL2!) {
                mailComposerVC.addAttachmentData(fileData2 as Data, mimeType: "text/txt", fileName: "CSVbutton.csv")
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


    func stopQueueUpdates() {
        guard let motion = motionManager, motion.isDeviceMotionAvailable else { return }
        motion.stopDeviceMotionUpdates()
    }
    
    func startQueuedUpdates() {
        guard let motion = motionManager, motion.isDeviceMotionAvailable else {
            // Device motion NOT available
            print("Device motion NOT available")
            return
        }
        var frequency = 50.0
      //  frequency = Double(String(freq.text!))!
        motion.deviceMotionUpdateInterval = 1.0 / frequency
        motion.showsDeviceMovementDisplay = true
        motion.startDeviceMotionUpdates(
            using: .xMagneticNorthZVertical, // Get the attitude relative to the magnetic north reference frame.
            to: .main, withHandler: { (data, error) in // TODO: main queue not recommended, self.queue
                // Make sure the data is valid before accessing it.
                if let validData = data {
                    
                    //self.data.time.append(NSDate().timeIntervalSince1970)
                    self.data.time.append(validData.timestamp)
                    print(NSDate().timeIntervalSince1970)
                    
                    self.data.roll.append(validData.attitude.roll)
                    self.data.pitch.append(validData.attitude.pitch)
                    self.data.yaw.append(validData.attitude.yaw)
                    
                    self.data.rotationRateX.append(validData.rotationRate.x)
                    self.data.rotationRateY.append(validData.rotationRate.y)
                    self.data.rotationRateZ.append(validData.rotationRate.z)
                    
                    self.data.userAccelerationX.append(validData.userAcceleration.x)
                    self.data.userAccelerationY.append(validData.userAcceleration.y)
                    self.data.userAccelerationZ.append(validData.userAcceleration.z)
                    
                    self.data.magneticfieldX.append(validData.magneticField.field.x)
                    self.data.magneticfieldY.append(validData.magneticField.field.y)
                    self.data.magneticfieldZ.append(validData.magneticField.field.z)
       
                  //self.showResults()
                    self.count = self.count + 1
                    
                    print(validData)
                }
        })
    }
    
    func resetSensorData() {
        count = 0
        data.time.removeAll()
        data.roll.removeAll()
        data.pitch.removeAll()
        data.yaw.removeAll()
        data.rotationRateX.removeAll()
        data.rotationRateY.removeAll()
        data.rotationRateZ.removeAll()
        data.userAccelerationX.removeAll()
        data.userAccelerationY.removeAll()
        data.userAccelerationZ.removeAll()
    }
    
}
