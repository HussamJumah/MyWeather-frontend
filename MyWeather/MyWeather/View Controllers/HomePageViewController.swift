//
//  HomePageViewController.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/1/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//
import Foundation
import UIKit

class HomePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Variable
    var currentWeather: Weather?
    private let dataManager = DataManager(baseURL: API.AuthenticatedBaseURL)

    // Outlets
    @IBOutlet weak var SearchNewLocation:UITextField!
    @IBOutlet weak var weatherLocation: UILabel!
    @IBOutlet weak var commentsTable: UITableView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var commentField: UITextField!
    @IBOutlet weak var weatherrDescriptionField: UILabel!
    
    // Actions
    @IBAction func sendCommentBtn(_ sender: Any) {
        if let weather = self.currentWeather, let user = Session.loggedInUser {
            let comment = Comment(commenter: user, time: getCurrentTime(), text: self.commentField.text!)
            weather.comments.append(comment)
            
            self.commentsTable.beginUpdates()
            let index = NSIndexPath(row: weather.comments.count-1, section: 0) as IndexPath
            self.commentsTable.insertRows(at: [index], with: .top)
            self.commentsTable.endUpdates()
            self.commentsTable.scrollToRow(at: index, at: .bottom, animated: true)
        }
    }
    
    @IBOutlet weak var CurrentDate: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
   // Fetch Weather Data
   dataManager.weatherDataForLocation(latitude: Defaults.Latitude, longitude: Defaults.Longitude) { (response, error) in
       print(response)
   }
        
        self.commentsTable.delegate = self
        self.commentsTable.dataSource = self
        self.commentsTable.register(UINib(nibName: "CommentTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsCellId")
        
        if let user = Session.loggedInUser {
            self.weatherLocation.text = user.defaultLocation
            self.currentWeather = getWeather(location: user.defaultLocation)
            self.updateView()
        }
        
        
        
        getCurrentDate()
        

    }
    
    func updateView() {
        guard let weather = currentWeather else {return}
        self.weatherLocation.text = weather.location
        // TODO: Replace the hyphan to degree symbol
        self.tempLabel.text = String(weather.temp) + "˚F"
        self.weatherrDescriptionField.text = weather.weatherDescription
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

    
    func getWeather(location: String) -> Weather {
        // Request frorm backend the location
        let comment1 = Comment(commenter: Session.loggedInUser!, time: "4:00", text: "Hello")
        let comment2 = Comment(commenter: Session.loggedInUser!, time: "4:00", text: "Hello2")
        let comment3 = Comment(commenter: Session.loggedInUser!, time: "4:00", text: "Hello3")
        return Weather(location: "New York City", time: "1:41", temp: 44, weatherDescription: "Partly Cloudy", comments: [comment1, comment2, comment3])
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

