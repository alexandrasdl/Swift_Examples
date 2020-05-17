//
//  ViewController.swift
//  motion_csv_mail
//
//  Created by Alexandra Lopes on 01/02/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit
import Foundation
import UIKit
import CoreMotion
import simd

struct SensorData {
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

class ViewController: UIViewController {

    var count: Int!
    var fileURL: URL!
    var data: SensorData! = SensorData()
    var motionManager: CMMotionManager? = CMMotionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        count = 0
    }

    @IBAction func start(_ sender: Any) {
        startQueuedUpdates()
    }
    
    @IBAction func stop(_ sender: Any) {
    
    }
    
    @IBAction func send(_ sender: Any) {
    
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
                    
                    print(self.data.userAccelerationX[self.count])
                }
        })

    }
}

