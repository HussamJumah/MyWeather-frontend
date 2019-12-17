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
    
    var activeField: UITextField?

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
        self.usernameField.delegate = self
        self.passwordField.delegate = self
        self.confirmField.delegate = self
        self.emailField.delegate = self
        self.defaultZipcode.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        // tag 1 = comment field
        guard let field = activeField, field.tag == 2 || field.tag == 3 || field.tag == 4 else {return}
        let keyboardFrame = keyboardSize.cgRectValue
        if self.view.frame.origin.y == 0 {
            self.view.frame.origin.y -= keyboardFrame.height
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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

extension RegisterationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
}
