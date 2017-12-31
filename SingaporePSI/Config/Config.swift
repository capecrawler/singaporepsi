//
//  Config.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 30/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation

struct Config {
    static let gmapsAPIKey = "AIzaSyCWIpr5uavwUGGlYNfC8JBvH5KdMCC6LDA"
    static let serverAPIKey = "A785Y5RosQxFC1T1cG1JoYPhkmkbcDlep"
    static let baseURL = "https://api.data.gov.sg/v1"
}

struct ServerConfig {
    var baseURL: String
    var headers: [String: String]
    static let appConfig = ServerConfig(baseURL: Config.baseURL, headers: ["api-key": Config.serverAPIKey])
}
