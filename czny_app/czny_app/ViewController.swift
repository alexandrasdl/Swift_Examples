//
//  ViewController.swift
//  czny_app
//
//  Created by Alexandra Lopes on 01/02/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var logview: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        let touch = touches.first!
        print("\(String(describing: touch.window))")
        print("\(touch.preciseLocation(in: logview))")
        print("\(touch.location(in: logview))")
        print("\(touch.majorRadius)")
        print("\(touch.majorRadiusTolerance)")
        print("\(touch.timestamp)")
        print("\(touch.tapCount)")
        print("\(touch.phase)")
        print("\(touch.altitudeAngle)")
        print("\(touch.azimuthAngle(in: logview))")
        print("\(touch.azimuthUnitVector(in: logview))")
        print("\(touch.estimatedProperties)")
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first!
        print("\(String(describing: touch.window))")
        print("\(touch.preciseLocation(in: logview))")
        print("\(touch.location(in: logview))")
        print("\(touch.majorRadius)")
        print("\(touch.majorRadiusTolerance)")
        print("\(touch.timestamp)")
        print("\(touch.tapCount)")
        print("\(touch.phase)")
        print("\(touch.altitudeAngle)")
        print("\(touch.azimuthAngle(in: logview))")
        print("\(touch.azimuthUnitVector(in: logview))")
        print("\(touch.estimatedProperties)")
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        let touch = touches.first!
        print("\(String(describing: touch.window))")
        print("\(touch.preciseLocation(in: logview))")
        print("\(touch.location(in: logview))")
        print("\(touch.majorRadius)")
        print("\(touch.majorRadiusTolerance)")
        print("\(touch.timestamp)")
        print("\(touch.tapCount)")
        print("\(touch.phase)")
        print("\(touch.altitudeAngle)")
        print("\(touch.azimuthAngle(in: logview))")
        print("\(touch.azimuthUnitVector(in: logview))")
        print("\(touch.estimatedProperties)")
    }

    
}
    
