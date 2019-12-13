//
//  ViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 11/29/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit

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
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let homePage = storyBoard.instantiateViewController(withIdentifier: "HomePageId") as! HomePageViewController
            
            self.navigationController?.setViewControllers([homePage], animated: true)
//            self.present(homePage, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

