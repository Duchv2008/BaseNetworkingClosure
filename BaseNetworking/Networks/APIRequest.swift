//
//  APIRequest.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class APIRequest: Mappable {
    
    init() {
        
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
    }
    
    var parameter: Parameters? {
        return self.toJSON()
    }
}

protocol BaseRouterNetwork: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var parameter: Parameters? { get }
}
