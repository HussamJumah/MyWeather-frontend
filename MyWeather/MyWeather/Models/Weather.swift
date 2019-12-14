//
//  Weather.swift
//  MyWeather
//
//  Created by Hussam Jumah on 12/12/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import Foundation

class Weather{
    var location : String
    var time : String
    var temp : Int
    var weatherDescription: String
    var comments:[Comment]


    init(location : String, time : String, temp : Int, weatherDescription: String, comments: [Comment]){
        self.location = location
        self.time = time
        self.temp = temp
        self.weatherDescription = weatherDescription
        self.comments = comments
    }


}

