//
//  PollutantStandardIndexOperation.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation
import SwiftyJSON

class PollutantStandardIndexOperation: NetworkOperationProtocol {
    
    var request: BaseRequest
    init() {
        self.request = BaseRequest(path: "/environment/psi")
    }
    
    func perform(onDispatcher dispatcher: DispatcherProtocol, completionHandler: @escaping (BaseResponse<Any>) -> Void) {
        dispatcher.execute(request: self.request, completionHandler: { response in
            switch response {
            case .success(let jsonResponse):
                print("ok: \(jsonResponse)")
                let model: [String:String] = [:]
                completionHandler(BaseResponse.success(model))
            case .error(let error):
                print("error: \(error)")
                completionHandler(BaseResponse.error(error))
            }
        })
    }
}
