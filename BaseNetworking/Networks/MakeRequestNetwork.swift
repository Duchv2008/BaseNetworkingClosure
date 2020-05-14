//
//  MakeRequestNetwork.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation
import Alamofire

private struct Constant {
    static let headerAccessTokenKey = "Authorization"
}

struct MakeRequestNetwork {
    var router: BaseRouterNetwork
    var baseUrl: String = "" // TODO: Add base url tại đây

    func makeRequest(autoAddToken: Bool = true) throws -> URLRequest {
        let url = try baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(router.path))
        urlRequest.httpMethod = router.method.rawValue
        urlRequest.setAccessToken(autoAddToken)
        switch router.method {
        case .get:
            urlRequest = try URLEncoding.default.encode(urlRequest, with: router.parameter)
        default:
            urlRequest = try JSONEncoding.default.encode(urlRequest, with: router.parameter)
        }
        return urlRequest
    }
}

private extension URLRequest {
    // TODO: Có access token thì add lại sau.
    mutating func setAccessToken(_ add: Bool) {
//        guard add else { return }
//        let token = "AppState.shared.sessionManager.accessToken"
//        guard token.present else { return }
//        let bearerToken = String(format: "Bearer %@", token)
//        self.setValue(bearerToken, forHTTPHeaderField: Constant.headerAccessTokenKey)
    }
}
