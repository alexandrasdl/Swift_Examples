//
//  senseButton.swift
//  czny_test
//
//  Created by Alexandra Lopes on 09/02/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit

class senseButton: UIButton {
    
    var time = Array<Any>()
    
    func test() -> Array<Any>{
        return time
    }
        
    override func touchesBegan(_ touches: Set<UITouch>, with  event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            let touch = touches.first!
           
           print("timestamp: ","\(touch.timestamp)")
           time.append(touch.timestamp)
        
            print("majorRadius: ","\(touch.majorRadius)")
            print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
            print("touch force","\(touch.force)")
            print("tap Count: ","\(touch.tapCount)")
            print("touch phase: ","\(touch.phase)")
            print("altitude angle","\(touch.altitudeAngle)")
        }

        override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesMoved(touches, with: event)
            let touch = touches.first!
          
          //    print("timestamp: ","\(touch.timestamp)")
       
              print("majorRadius: ","\(touch.majorRadius)")
              print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
              print("touch force","\(touch.force)")
              print("tap Count: ","\(touch.tapCount)")
              print("touch phase: ","\(touch.phase)")
              print("altitude angle","\(touch.altitudeAngle)")

                
        }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        let touch = touches.first!
      
           print("timestamp: ","\(touch.timestamp)")
           time.append(touch.timestamp)
           print("majorRadius: ","\(touch.majorRadius)")
           print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
           print("touch force","\(touch.force)")
           print("tap Count: ","\(touch.tapCount)")
           print("touch phase: ","\(touch.phase)")
           print("altitude angle","\(touch.altitudeAngle)")

    }
        override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesCancelled(touches, with: event)
            let touch = touches.first!
          
               print("timestamp: ","\(touch.timestamp)")
        
               print("majorRadius: ","\(touch.majorRadius)")
               print("majorRadius Tolerance: ","\(touch.majorRadiusTolerance)")
               print("touch force","\(touch.force)")
               print("tap Count: ","\(touch.tapCount)")
               print("touch phase: ","\(touch.phase)")
               print("altitude angle","\(touch.altitudeAngle)")

        }

}
