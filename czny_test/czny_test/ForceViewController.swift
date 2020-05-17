//
//  ForceViewController.swift
//  czny_test
//
//  Created by Alexandra Lopes on 09/02/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit

class ForceViewController: UIViewController {

    @IBOutlet weak var logview: UIView!
    @IBOutlet weak var btn: UIButton!
    
    @IBOutlet weak var loc: UILabel!
    @IBOutlet weak var ploc: UILabel!
    
    @IBOutlet weak var radius: UILabel!
    @IBOutlet weak var pradius: UILabel!
    
    @IBOutlet weak var force: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with  event: UIEvent?) {
         super.touchesBegan(touches, with: event)
         let touch = touches.first!
        
         print("timestamp: ","\(touch.timestamp)")
        
         print("location: ","\(touch.location(in: logview))")
         loc.text = "Location: " + "\(touch.location(in: logview))"
        
         print("previousLocation: ","\(touch.location(in: logview))")
        
         print("precise location: ","\(touch.preciseLocation(in: logview))")
         ploc.text = "Precise Location: " + "\(touch.preciseLocation(in: logview))"
        
         print("precise previousLocation: ","\(touch.precisePreviousLocation(in: logview))")
  
         print("Major Radius: ","\(touch.majorRadius)")
         radius.text = "Radius: " + "\(touch.majorRadius)"
        
         print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
         pradius.text = "Radius Tolerance: " + "\(touch.majorRadiusTolerance)"
        
         print("touch force","\(touch.force)")
         force.text = "Force: " + "\(touch.force)"
        
         print("tap Count: ","\(touch.tapCount)")
         print("touch phase: ","\(touch.phase)")
         print("altitude angle","\(touch.altitudeAngle)")
         print("azimuth angle","\(touch.azimuthAngle(in: logview))")
         print("azimuth unitvector","\(touch.azimuthUnitVector(in: logview))")
         
         print("estimated properties","\(touch.estimatedProperties)")
         print("Touch type: ","\(touch.type)")
         print("\(String(describing: touch.window))")
              
     }

     override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
         super.touchesMoved(touches, with: event)
                 let touch = touches.first!
              
               print("timestamp: ","\(touch.timestamp)")
              
               print("location: ","\(touch.location(in: logview))")
               loc.text = "Location: " + "\(touch.location(in: logview))"
              
               print("previousLocation: ","\(touch.location(in: logview))")
              
               print("precise location: ","\(touch.preciseLocation(in: logview))")
               ploc.text = "Precise Location: " + "\(touch.preciseLocation(in: logview))"
              
               print("precise previousLocation: ","\(touch.precisePreviousLocation(in: logview))")
        
               print("Major Radius: ","\(touch.majorRadius)")
               radius.text = "Radius: " + "\(touch.majorRadius)"
              
               print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
               pradius.text = "Radius Tolerance: " + "\(touch.majorRadiusTolerance)"
              
               print("touch force","\(touch.force)")
               force.text = "Force: " + "\(touch.force)"
              
               print("tap Count: ","\(touch.tapCount)")
               print("touch phase: ","\(touch.phase)")
               print("altitude angle","\(touch.altitudeAngle)")
               print("azimuth angle","\(touch.azimuthAngle(in: logview))")
               print("azimuth unitvector","\(touch.azimuthUnitVector(in: logview))")
               
               print("estimated properties","\(touch.estimatedProperties)")
               print("Touch type: ","\(touch.type)")
               print("\(String(describing: touch.window))")
             
     }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesEnded(touches, with: event)
                    let touch = touches.first!
                 
                  print("timestamp: ","\(touch.timestamp)")
                 
                  print("location: ","\(touch.location(in: logview))")
                  loc.text = "Location: " + "\(touch.location(in: logview))"
                 
                  print("previousLocation: ","\(touch.location(in: logview))")
                 
                  print("precise location: ","\(touch.preciseLocation(in: logview))")
                  ploc.text = "Precise Location: " + "\(touch.preciseLocation(in: logview))"
                 
                  print("precise previousLocation: ","\(touch.precisePreviousLocation(in: logview))")
           
                  print("Major Radius: ","\(touch.majorRadius)")
                  radius.text = "Radius: " + "\(touch.majorRadius)"
                 
                  print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
                  pradius.text = "Radius Tolerance: " + "\(touch.majorRadiusTolerance)"
                 
                  print("touch force","\(touch.force)")
                  force.text = "Force: " + "\(touch.force)"
                 
                  print("tap Count: ","\(touch.tapCount)")
                  print("touch phase: ","\(touch.phase)")
                  print("altitude angle","\(touch.altitudeAngle)")
                  print("azimuth angle","\(touch.azimuthAngle(in: logview))")
                  print("azimuth unitvector","\(touch.azimuthUnitVector(in: logview))")
                  
                  print("estimated properties","\(touch.estimatedProperties)")
                  print("Touch type: ","\(touch.type)")
                  print("\(String(describing: touch.window))")
        }


     override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
         super.touchesCancelled(touches, with: event)
                 let touch = touches.first!
              
               print("timestamp: ","\(touch.timestamp)")
              
               print("location: ","\(touch.location(in: logview))")
        
               loc.text = "Location: " + "\(touch.location(in: logview))"
              
               print("previousLocation: ","\(touch.location(in: logview))")
              
               print("precise location: ","\(touch.preciseLocation(in: logview))")
               ploc.text = "Precise Location: " + "\(touch.preciseLocation(in: logview))"
              
               print("precise previousLocation: ","\(touch.precisePreviousLocation(in: logview))")
        
               print("Major Radius: ","\(touch.majorRadius)")
               radius.text = "Radius: " + "\(touch.majorRadius)"
              
               print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
               pradius.text = "Radius Tolerance: " + "\(touch.majorRadiusTolerance)"
              
               print("touch force","\(touch.force)")
               force.text = "Force: " + "\(touch.force)"
              
               print("tap Count: ","\(touch.tapCount)")
               print("touch phase: ","\(touch.phase)")
               print("altitude angle","\(touch.altitudeAngle)")
               print("azimuth angle","\(touch.azimuthAngle(in: logview))")
               print("azimuth unitvector","\(touch.azimuthUnitVector(in: logview))")
               
               print("estimated properties","\(touch.estimatedProperties)")
               print("Touch type: ","\(touch.type)")
               print("\(String(describing: touch.window))")
     }

}
