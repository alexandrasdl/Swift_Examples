//
//  customButton.swift
//  mail_test
//
//  Created by Alexandra Lopes on 05/02/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit

class customButton: UIButton {

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches{
            print("% Touch pressure: \(touch.majorRadius)");
        }
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Touches End")
    }
}

extension UIWindow
{
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        print("kb touch")

        for touch in touches
        {
           let pressure = touch.majorRadius
           print("pressure is: \(String(describing: pressure))")
        }
    }

    override open func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print("hittest")

        let view = super.hitTest(point, with: event)

        if (NSStringFromClass(type(of: self)) == "UIRemoteKeyboardWindow")
        {
            //will result in touchesBegan being called
            return self;
        }

        return view
    }
}
