//
//  NetworkOperationProtocol.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation

protocol NetworkOperationProtocol: OperationProtocol {
    var request: BaseRequest { get set }
}
