//
//  Configuration.swift
//  MyWeather
//
//  Created by Matthew Slazak on 12/14/19.
//  Copyright © 2019 Hussam Jumah. All rights reserved.
//

import Foundation

struct API{
    static let APIKey = "7553af517e1ca3f448a40f64a7c569ed"
    static let BaseURL = URL(string: "https://api.darksky.net/forecast/")!
    static var AuthenticatedBaseURL: URL {
    return BaseURL.appendingPathComponent(APIKey)
    }
}
struct Defaults {

    static let Latitude: Double = 37.8267
    static let Longitude: Double = -122.423

}
