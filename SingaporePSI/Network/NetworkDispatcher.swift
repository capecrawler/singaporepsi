//
//  NetworkDispatcher.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation
import Alamofire

class NetworkDispatcher: Dispatcher {
    let serverConfig: ServerConfig
    init(serverConfig: ServerConfig) {
        self.serverConfig = serverConfig
    }
    
    func execute(request: RequestProtocol) {
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
                print("success")
            case .failure(let error):
                print("error \(error)")
            }
        }
    }
}
