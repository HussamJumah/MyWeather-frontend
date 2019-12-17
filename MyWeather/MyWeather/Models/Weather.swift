//
//  Weather.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/12/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import Foundation
import SwiftyJSON
class Weather{
    var city : String
    var temp : String
    var weatherDescription: String
    var comments:[Comment]


    init(city : String, temp : String, weatherDescription: String, comments: [Comment] = []){
        self.city = city
        self.temp = temp
        self.weatherDescription = weatherDescription
        self.comments = comments
    }
    
    static func FromJSON(_ json: JSON) -> Weather {
        let city = json["weather"]["city"].stringValue
        let temperature = json["weather"]["temperature"].stringValue
        let description = json["weather"]["description"].stringValue
        
        let weather = Weather(city: city, temp: temperature, weatherDescription: description)
        if let commentsDict = json["comments"].array {
            weather.comments  = commentsDict.map { return Comment.FromJSON($0)}
        }
        
        return weather
    }
}

