//
//  PollutantStandardIndex.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation

class PollutantStandardIndex {
    let items: [String: Region]
    let timestamp: Date
    let updateTimestamp: Date
    
    init(items: [String: Region], timestamp: Date, updateTimestamp: Date) {
        self.items = items
        self.timestamp = timestamp
        self.updateTimestamp = updateTimestamp
    }
}

class Region {
    let name: String
    let latitude: Float
    let longitude: Float
    var readings:[String: Float]
    
    init(name: String, latitude: Float, longitude: Float, readings: [String: Float]) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.readings = readings
    }
}
