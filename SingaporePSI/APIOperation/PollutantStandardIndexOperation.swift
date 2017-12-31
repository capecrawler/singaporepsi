//
//  PollutantStandardIndexOperation.swift
//  SingaporePSI
//
//  Created by Mario Antonio Cape on 31/12/2017.
//  Copyright © 2017 Mario Antonio Cape. All rights reserved.
//

import Foundation
import SwiftyJSON
import DateParser

class PollutantStandardIndexOperation: NetworkOperationProtocol {
    
    internal var request: BaseRequest
    init() {
        self.request = BaseRequest(path: "/environment/psi")
    }
    
    func perform(onDispatcher dispatcher: DispatcherProtocol, completionHandler: @escaping (BaseResponse<Any>) -> Void) {
        dispatcher.execute(request: self.request, completionHandler: { response in
            switch response {
            case .success(let jsonResponse):
                print("ok: \(jsonResponse)")
                let psi = self.parseJson(json: jsonResponse as! JSON)
                completionHandler(BaseResponse.success(psi))
            case .error(let error):
                print("error: \(error)")
                completionHandler(BaseResponse.error(error))
            }
        })
    }
}

private extension PollutantStandardIndexOperation {
    func parseJson(json: JSON)->PollutantStandardIndex {
        var regions = [String: Region]()
        var timestamp = Date()
        var updateTimestamp = Date()
        
        if let regionMetaData = json["region_metadata"].array {
            for regionJson in regionMetaData {
                let name = regionJson["name"].string!
                let location = regionJson["label_location"]
                let latitude = location["latitude"].float!
                let longitude = location["longitude"].float!
                regions[name] = Region(name: name, latitude: latitude, longitude: longitude, readings: [:])
            }
        }
        
        let timestampString = json["items"][0]["timestamp"].string!
        do { timestamp = try Date(dateString: timestampString) } catch {}
        
        let updateTimestampString = json["items"][0]["update_timestamp"].string!
        do { updateTimestamp = try Date(dateString: updateTimestampString) } catch {}
        
        let readings = json["items"][0]["readings"]
        for (pollutants, valuesInLocation) in readings {
            print("pollutants: \(pollutants)")
            for (key, value) in valuesInLocation {
                var region = regions[key]
                region?.readings[pollutants] = value.float!
            }
        }
        
        return PollutantStandardIndex(items: regions, timestamp: timestamp, updateTimestamp: updateTimestamp)
    }
}
