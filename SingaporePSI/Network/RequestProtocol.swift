//
//  RequestProtocol.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 30/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation
import Alamofire


protocol RequestProtocol {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: Parameters? { get }
    var headers: [String: String]? { get }
}

extension RequestProtocol {
    var method: HTTPMethod { return .get }
    var params: Parameters { return [:] }
    var headers: [String: String] { return [:] }
}
