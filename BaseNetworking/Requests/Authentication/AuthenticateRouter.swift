//
//  AuthenticateRouter.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation
import Alamofire

enum AuthenticateRouter {
    /**
     Login
     */
    case login(req: APIRequest)
}

extension AuthenticateRouter: BaseRouterNetwork {
    var method: HTTPMethod {
        switch self {
        case .login:
            return .post
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .login:
            return "" // TODO: Add url login tại đâu
        }
    }

    var parameter: Parameters? {
        switch self {
        case .login(let req):
            return req.parameter
        default:
            return nil
        }
    }

    var autoAddToken: Bool {
        switch self {
        case .login:
            return false
        default:
            return true
        }
    }

    func asURLRequest() throws -> URLRequest {
        return try MakeRequestNetwork(router: self).makeRequest(autoAddToken: autoAddToken)
    }
}
