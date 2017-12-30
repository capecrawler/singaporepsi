//
//  Request.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 30/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get, post // we can add more
}

protocol Request {
    var path: String { get }
    var method: HTTPMethod { get }
    var params: [String: Any]? { get }
    var headers: [String: String]? { get }
}

extension Request {
    var method: HTTPMethod { return .get }
    var params: [String: Any]? { return nil }
    var headers: [String: String]? { return nil }
}
