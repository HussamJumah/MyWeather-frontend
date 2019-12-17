//
//  RegisterationViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 11/30/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit
import SwiftyJSON

class RegisterationViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var defaultZipcode: UITextField!
    
    
    @IBAction func CancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }
    
    @IBAction func SignUpButton(_ sender: Any) {
        if passwordField.text != confirmField.text {
            let alertController = UIAlertController(title: "Error", message: "passwords do not match.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            // Sign up Or run more checks like important fields are filled
            var body = Dictionary<String, Any>()
            body["username"] = usernameField.text
            body["password"] = passwordField.text
            body["email"] = emailField.text
            body["defaultZipcode"] = defaultZipcode.text
            
            NetworkService.standard.request(target: API.register(body: body), success: { (data) in
                self.dismiss(animated: true, completion: nil)
//                let response = JSON(data as Any)
//
//                Session.loggedInUser = User.FromJSON(response)
//
//                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
//                let homePage = storyBoard.instantiateViewController(withIdentifier: "HomePageId") as! HomePageViewController
//                self.navigationController?.setViewControllers([homePage], animated: true)
                
            }, error: { (err) in
                let alertController = UIAlertController(title: "Error", message: "Unknown error occured", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }) { (failure) in
                let alertController = UIAlertController(title: "Error", message: "Unknown error occured", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
