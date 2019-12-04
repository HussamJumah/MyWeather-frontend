//
//  ViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 11/29/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var UsernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
  //assume keyboard hides
    func textFieldShouldReturn(UsernameTextField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return true
    }

}

