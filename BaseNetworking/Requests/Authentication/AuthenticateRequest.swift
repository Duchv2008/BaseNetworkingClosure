//
//  AuthenticateRequest.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation

class AuthenticateRequest {
    func login(req: LoginRequest, success: ((LoginResponse) -> Void)?, fail: ((APIError) -> Void)?) {
        let router = AuthenticateRouter.login(req: req)
        return RequestManager.shared.callRequest(url: router, success: success, fail: fail)
    }
}
