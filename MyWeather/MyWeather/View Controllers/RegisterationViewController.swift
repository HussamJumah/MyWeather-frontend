//
//  RegisterationViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 11/30/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit

class RegisterationViewController: UIViewController {
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    
    @IBAction func CancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        if passwordField.text != confirmField.text {
            let alertController = UIAlertController(title: "Error", message: "passwords do not match.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            // Sign up Or run more checks like important fields are filled
        }
    }
}
