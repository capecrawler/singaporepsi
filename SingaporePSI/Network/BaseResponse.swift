//
//  BaseResponse.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation

enum BaseResponse<T> {
    case success(T)
    case error(Error)
}
