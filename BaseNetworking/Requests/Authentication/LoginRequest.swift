//
//  LoginRequest.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation
import ObjectMapper

class LoginRequest: APIRequest {
    var username: String = ""
    var password: String = ""
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        super.init()
    }
    
    required init?(map: Map) {
        super.init()
    }
    
    override func mapping(map: Map) {
        username <- map["email"]
        password <- map["password"]
    }
}
