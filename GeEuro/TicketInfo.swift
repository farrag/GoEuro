//
//  TicketInfo.swift
//  GeEuro
//
//  Created by Ahmad Farrag on 10/11/16.
//  Copyright © 2016 Ahmad Farrag. All rights reserved.
//

import Foundation

let kIDKey = "id"
let kArrivalTimeKey = "arrival_time"
let kDepartureTimeKey = "departure_time"
let kNumberOfStopsKey = "number_of_stops"
let kPriceInEurosKey = "price_in_euros"
let kProviderLogoKey = "provider_logo"

class TicketInfo: NSObject {
    var arrivalTime: String = ""
    var departureTime: String = ""
    var id: Int = 0
    var numberOfStops: Int = 0
    var price: Float = 0.0
    var providerLogo: String = ""
    
    init(usingDicationary dictionary: Dictionary<String, AnyObject>) {
        self.id = dictionary[kIDKey] as! Int
        self.arrivalTime = dictionary[kArrivalTimeKey] as! String
        self.departureTime = dictionary[kDepartureTimeKey] as! String
        self.numberOfStops = dictionary[kNumberOfStopsKey] as! Int
        self.price = dictionary[kPriceInEurosKey] as! Float
        self.providerLogo = (dictionary[kProviderLogoKey] as! NSString).replacingOccurrences(of: "{size}", with: "63")
    }
}
