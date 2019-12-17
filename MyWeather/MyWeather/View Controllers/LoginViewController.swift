//
//  ViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 11/29/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit
import SwiftyJSON
class LoginViewController: UIViewController {

    // Outlets
    @IBOutlet weak var UsernameTextField: UITextField!
    @IBOutlet weak var PasswordTextFieeld: UITextField!
    
    @IBAction func LoginTapped(_ sender: Any) {
        if UsernameTextField.text == "" || PasswordTextFieeld.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Username and/or password can not be empty.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
            
            alertController.addAction(okAction)
            
            self.present(alertController, animated: true, completion: nil)
        } else {
            var body = Dictionary<String, Any>()
            body["username"] = UsernameTextField.text
            body["password"] = PasswordTextFieeld.text
            
            NetworkService.standard.request(target: .login(body: body), success: { (data) in
                let response = JSON(data as Any)
                
                Session.loggedInUser = User.FromJSON(response)
                
                let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                let homePage = storyBoard.instantiateViewController(withIdentifier: "HomePageId") as! HomePageViewController
                self.navigationController?.setViewControllers([homePage], animated: true)
            }, error: { (error) in
                print("ERRRR")
                print(error)
                let alertController = UIAlertController(title: "Error", message: "Unknown error occured", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }) { (failure) in
                print("FAILURE")
                print(failure)
                let alertController = UIAlertController(title: "Error", message: "Unknown error occured", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Okay", style: UIAlertAction.Style.default, handler: nil)
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
            
//            self.present(homePage, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

    }

}

