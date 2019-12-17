//
//  HomePageViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/1/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//
import Foundation
import UIKit
import SwiftyJSON

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Variable
    var currentWeather: Weather?
    var currentZipcode: String?
    var activeField: UITextField?

    // Outlets
    @IBOutlet weak var SearchNewLocation:UITextField! {
        didSet {
            SearchNewLocation?.addDoneCancelToolbar(onDone: (target: self, action: #selector(performTextFieldSearch)), doneText: "Search")
        }
    }
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
                comment.commenter = user
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

    @IBAction func refreshBtn(_ sender: Any) {
        guard let zipcode = self.currentZipcode else {return}
        NetworkService.standard.request(target: .search(zipcode: zipcode), success: { (data) in
            let response = JSON(data as Any)
            print(response)
            let weather = Weather.FromJSON(response)
            self.currentWeather = weather
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



    @IBOutlet weak var CurrentDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()

        self.SearchNewLocation.delegate = self
        self.commentField.delegate = self

        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)


   // Fetch Weather Data
   dataManager.weatherDataForLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude) { (response, error) in
       print(response)
   }

        self.commentsTable.delegate = self
        self.commentsTable.dataSource = self
        self.commentsTable.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsCellId")

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
        guard let userInfo = notification.userInfo else {return}
        guard let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {return}
        // tag 1 = comment field
        guard let field = activeField, field.tag == 1 else {return}
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
        textField.resignFirstResponder()  //if desired

        // If the textfield is equal to the search
        if textField.tag == 0 {
            performTextFieldSearch()
        }
        return true
    }

    @objc func performTextFieldSearch() {
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

        if let field = self.activeField {
            field.resignFirstResponder()
        }
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
}
