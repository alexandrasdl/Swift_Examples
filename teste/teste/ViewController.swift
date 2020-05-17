//
//  ViewController.swift
//  teste
//
//  Created by Alexandra Lopes on 04/01/2020.
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
}

class ViewController: UIViewController, MFMailComposeViewControllerDelegate{
    
    var employeeArray:[Dictionary<String, AnyObject>] =  Array()
    
    var count: Int!
    var fileURL: URL!
    var data: SensorData! = SensorData()
    var motionManager: CMMotionManager? = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 0
        // Do any additional setup after loading the view.
        for i in 1...10 {
            var dct = Dictionary<String, AnyObject>()
            dct.updateValue(i as AnyObject, forKey: "EmpID")
            dct.updateValue("NameForEmplyee id = \(i)" as AnyObject, forKey: "EmpName")
            employeeArray.append(dct)
        }
        
        print(employeeArray)
    }
    
    @IBAction func start(_ sender: Any) {
        resetSensorData()
        startQueuedUpdates()
    }
    
    @IBAction func stop(_ sender: Any) {
        stopQueueUpdates()
        print(data!)
    }
    
    @IBAction func send(_ sender: Any) {
        for i in 0 ..< count  {
            var dct = Dictionary<String, AnyObject>()
            dct.updateValue(self.data.time[i] as AnyObject, forKey: "EmpID")
            dct.updateValue(self.data.userAccelerationX[i] as AnyObject, forKey: "EmpName")
            employeeArray.append(dct)
        }
        
        createCSV(from: employeeArray)
        let mailComposerViewController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposerViewController,animated: true, completion: nil)
        } else {
            showMailError()
        }
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
          let fileURL2 = url.appendingPathComponent("CSVRec.csv")
          print(fileURL)
          print("ok")
          
          if let fileData = NSData(contentsOf: fileURL!) {
              mailComposerVC.addAttachmentData(fileData as Data, mimeType: "text/txt", fileName: "CSVRec.csv")
          }
        
            if let fileData2 = NSData(contentsOf: fileURL2!) {
                mailComposerVC.addAttachmentData(fileData2 as Data, mimeType: "text/txt", fileName: "CSVRec.csv")
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
        
        motion.deviceMotionUpdateInterval = 1.0 / 60.0
        motion.showsDeviceMovementDisplay = true
        motion.startDeviceMotionUpdates(
            using: .xMagneticNorthZVertical, // Get the attitude relative to the magnetic north reference frame.
            to: .main, withHandler: { (data, error) in // TODO: main queue not recommended, self.queue
                // Make sure the data is valid before accessing it.
                if let validData = data {
                    
                    self.data.time.append(NSDate().timeIntervalSince1970)
                    
                    self.data.roll.append(validData.attitude.roll)
                    self.data.pitch.append(validData.attitude.pitch)
                    self.data.yaw.append(validData.attitude.yaw)
                    
                    self.data.rotationRateX.append(validData.rotationRate.x)
                    self.data.rotationRateY.append(validData.rotationRate.y)
                    self.data.rotationRateZ.append(validData.rotationRate.z)
                    
                    self.data.userAccelerationX.append(validData.userAcceleration.x)
                    self.data.userAccelerationY.append(validData.userAcceleration.y)
                    self.data.userAccelerationZ.append(validData.userAcceleration.z)
                    
                    self.count = self.count + 1
                    
                    print("time: ",self.data.time[self.count-1],"x: ", self.data.userAccelerationX[self.count-1])
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
    
