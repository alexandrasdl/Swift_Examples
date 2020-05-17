//
//  ViewController.swift
//  keyboard_test
//
//  Created by Alexandra Lopes on 24/02/2020.
//  Copyright © 2020 Alexandra Lopes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, KeyboardDelegate {

    @IBOutlet weak var textField: UITextField!
    
        override func viewDidLoad() {
            super.viewDidLoad()

            // initialize custom keyboard
            let keyboardView = Keyboard(frame: CGRect(x: 0, y: 0, width: 0, height: 300))
            keyboardView.delegate = self // the view controller will be notified by the keyboard whenever a key is tapped

            // replace system keyboard with custom keyboard
            textField.inputView = keyboardView
        }

        // required method for keyboard delegate protocol
        func keyWasTapped(character: String) {
            textField.insertText(character)
        }
    }

