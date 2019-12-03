//
//  HomePageViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/1/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit

class HomePageViewController: UIViewController {

    @IBOutlet weak var SearchNewLocation:UITextField!
    
    
    @IBOutlet weak var CurrentDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate()

    }
    
    func getCurrentDate(){
          let formatter=DateFormatter()
         // formatter.dateStyle = .short  // gets date preset for you
        formatter.dateFormat="EEEE, MMMM dd, yyyy"  //to show the date in a custom way
          let str = formatter.string(from:Date())
          CurrentDate.text = str
      }
  
}
