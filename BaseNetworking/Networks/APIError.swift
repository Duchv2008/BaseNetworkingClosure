//
//  APIError.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation
import ObjectMapper

protocol APIErrorProtocol: Error {
    var code: Int? { get set }
    var message: Any? { get set }
}

public class APIError: APIErrorProtocol {
    public var code: Int?
    public var message: Any?

    public init(code: Int? = nil, message: Any? = nil) {
        self.code = code
        self.message = message
    }
}

extension APIError {
    static var decodeError: APIError {
        return APIError(message: "Mapping object error")
    }
}
