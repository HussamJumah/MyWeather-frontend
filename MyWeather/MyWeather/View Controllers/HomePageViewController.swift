//
//  HomePageViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/1/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Variable
    var currentWeather: Weather?
    var currentZipcode: String?
    
    // Outlets
    @IBOutlet weak var SearchNewLocation:UITextField!
    @IBOutlet weak var weatherLocation: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var weatherrDescriptionField: UILabel!
    
    // Actions
    @IBAction func sendCommentBtn(_ sender: Any) {
        if let weather = self.currentWeather, let user = Session.loggedInUser, let zipcode = self.currentZipcode {
            var body = Dictionary<String, Any>()
            
            body["commenter"] = user.id
            body["comment"] = self.commentField.text!
  
            NetworkService.standard.request(target: .comment(body: body, zipcode: zipcode), success: { (data) in
                let response = JSON(data as Any)
                let comment = Comment.FromJSON(response)
                
                weather.comments.append(comment)
                self.commentsTable.beginUpdates()
                let index = NSIndexPath(row: weather.comments.count-1, section: 0) as IndexPath
                self.commentsTable.insertRows(at: [index], with: .top)
                self.commentsTable.endUpdates()
                self.commentsTable.scrollToRow(at: index, at: .bottom, animated: true)
            }, error: { (error) in
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

    
    @IBOutlet weak var CurrentDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        self.commentsTable.delegate = self
        self.commentsTable.dataSource = self
        self.commentsTable.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsCellId")
        self.SearchNewLocation.delegate = self
        if let user = Session.loggedInUser {
//            self.weatherLocation.text = user.defaultZipcode
//            self.currentWeather = getWeather(zipcode: user.defaultZipcode)
            
            NetworkService.standard.request(target: .search(zipcode: user.defaultZipcode), success: { (data) in
                let response = JSON(data as Any)
                print(response)
                let weather = Weather.FromJSON(response)
                self.currentWeather = weather
                self.currentZipcode = user.defaultZipcode
                self.updateView()
            }, error: { (errorr) in
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
        
        getCurrentDate()

    }
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func updateView() {
        guard let weather = currentWeather else {return}
        self.weatherLocation.text = weather.city
        // TODO: Replace the hyphan to degree symbol
        self.tempLabel.text = weather.temp + "˚F"
        self.weatherrDescriptionField.text = weather.weatherDescription
        self.commentsTable.reloadData()
    }
    
    func getCurrentDate(){
        let formatter=DateFormatter()
        // formatter.dateStyle = .short  // gets date preset for you
        formatter.dateFormat="EEEE, MMMM dd, yyyy"  //to show the date in a custom way
        let str = formatter.string(from:Date())
        CurrentDate.text = str
    }
    
    func getCurrentTime() -> String {
        let formatter=DateFormatter()
        formatter.dateFormat = "h:mm a"
        let str = formatter.string(from: Date())
        return str
    }

    
//    func getWeather(zipcode: String) -> Weather{
//
//        // Request frorm backend the location
////        let comment1 = Comment(commenter: Session.loggedInUser!, time: "4:00", text: "Hello")
////        let comment2 = Comment(commenter: Session.loggedInUser!, time: "4:00", text: "Hello2")
////        let comment3 = Comment(commenter: Session.loggedInUser!, time: "4:00", text: "Hello3")
////        return Weather(city: "New York", temp: "44", weatherDescription: "Partly Cloudy", comments: [comment1, comment2, comment3])
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if let weather = self.currentWeather {
            return weather.comments.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCellId", for: indexPath as IndexPath) as! CommentTableViewCell
        
        if let weather = self.currentWeather {
            cell.comment = weather.comments[indexPath.row]
            cell.updateView()
        }
        
        return cell
    }
}

extension HomePageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        //textField code

        textField.resignFirstResponder()  //if desired
        performAction()
        return true
    }

    func performAction() {
      print("DONE")
        NetworkService.standard.request(target: .search(zipcode: SearchNewLocation.text!), success: { (data) in
            let response = JSON(data as Any)
            
            let weather = Weather.FromJSON(response)
            self.currentWeather = weather
            self.currentZipcode = self.SearchNewLocation.text!
            self.updateView()
        }, error: { (errorr) in
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
