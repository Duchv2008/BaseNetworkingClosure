//
//  ErrorCode.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation

///Define http status
enum HTTPStatusCode: Int {
    // OK
    case code200       = 200

    // Mapping Object
    case codeMapping   = 99

    // Invalid parameter supplied
    case code400       = 400

    // Invalid Token
    case code401       = 401

    // Timeout
    case code408       = 408

    // Too many requests
    case code429       = 429

    // Network error
    case code404       = 404
}
