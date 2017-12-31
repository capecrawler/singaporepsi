//
//  PollutantStandardIndexOperation.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation

class PollutantStandardIndexOperation: NetworkOperationProtocol {
    var request: BaseRequest
    init() {
        self.request = BaseRequest(path: "/environment/psi")
    }
    
    func perform(onDispatcher dispatcher: DispatcherProtocol) {
        dispatcher.execute(request: self.request)
    }
}
