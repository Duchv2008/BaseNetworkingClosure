//
//  BaseResponse.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation
import ObjectMapper

class BaseResponse<T: Mappable>: Mappable {
    var responseMessage: String?
    var responseStatus: Int?
    var totalRecords: Int?
    
    var isSuccess: Bool {
        if let statusCode = responseStatus {
            return statusCode < 300 && statusCode >= 200
        }
        else {
            return false
        }
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        responseMessage <- map["responseMessage"]
        responseStatus <- map["responseStatus"]
        totalRecords <- map["totalRecords"]
    }
}

// MARK: - When obj response is a Dictinary
class GeneralityResponse<T: Mappable>: BaseResponse<T> {
    var obj: T?
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        obj <- map["obj"]
    }
}

// MARK: - When obj response is array of Dictinary
class GeneralityResponses<T: Mappable>: BaseResponse<T> {
    var obj = [T]()
    
    required init?(map: Map) {
        super.init(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        obj <- map["obj"]
    }
}
