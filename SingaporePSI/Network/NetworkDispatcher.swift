//
//  NetworkDispatcher.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class NetworkDispatcher: DispatcherProtocol {
    
    let serverConfig: ServerConfig
    init(serverConfig: ServerConfig) {
        self.serverConfig = serverConfig
    }
    
    func execute(request: RequestProtocol, completionHandler: @escaping (BaseResponse<Any>) -> Void) {
        let urlPath = serverConfig.baseURL + request.path
        var headers = [String: String]()
        for (key, value) in serverConfig.headers {
            headers[key] = value
        }
        for (key, value) in request.headers {
            headers[key] = value
        }
        
        Alamofire.request(urlPath, method: request.method, parameters: request.params, encoding: URLEncoding.default, headers: headers).responseJSON { (response) in
            switch response.result {
            case .success:
                let jsonResponse = response.result.value ?? ""
                completionHandler(BaseResponse.success(JSON(jsonResponse)))
            case .failure(let error):
                completionHandler(BaseResponse.error(error))
            }
        }
    }
}
