//
//  BaseRequest.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest:RequestProtocol {
    var path: String
    var method: HTTPMethod?
    var params: Parameters?
    var headers: [String: String]?
    
    init(path: String, params: Parameters = [:]) {
        self.path = path
        self.params = params
    }
}
