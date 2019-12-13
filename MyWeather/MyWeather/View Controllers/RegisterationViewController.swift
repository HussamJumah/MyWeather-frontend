//
//  RegisterationViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 11/30/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit

class RegisterationViewController: UIViewController {

    @IBAction func CancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var confirmField: UITextField!
    
    
    @IBAction func SignUpButton(_ sender: Any) {

              var a = false
              var b = false

              if passwordField.text == confirmField.text {

                  a = true

              } else {
                  //Passwords dont match
                
                // ModalPasswordErrorViewController.modalPresentationStyle = .fullscreen
               
             //   let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               // let ModalPasswordErrorViewController = storyBoard.instantiateViewController(withIdentifier: "ModalPasswordErrorViewController") as! ModalPasswordErrorViewController
                 //       self.present(ModalPasswordErrorViewController, animated: true, completion: nil)
                //navigationController!.popToViewController(navigationController!.viewControllers[3], animated: false)
                
                //navigationController!.popToViewController(ModalPasswordErrorViewController, animated: false)
                
            //    navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>)
                
        }

              if(passwordField.text == "" || confirmField.text == "") {
                  //alert saying there are empty fields

              } else {

                  b = true
              }

              if a == true && b == true {
                
                
                //Signup code
              }
        }
        
    }
