//
//  RequestManager.swift
//  BaseNetworking
//
//  Created by Nhocbangchu95 on 5/14/20.
//  Copyright © 2020 Nhocbangchu95. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

private struct Constant {
    static var MappingObjectError: APIError {
        return APIError.decodeError
    }
}

class RequestManager {
    typealias SuccessHandle = ([String: Any]) -> Void
    typealias FailedHandle = (APIError) -> Void
    
    static let shared = RequestManager()
    private let sessionManager: Session!
    private var headers: HTTPHeaders = [:]
    
    private init() {
        headers["Content-Type"] = "application/json"
        
        let configuration = URLSessionConfiguration.default
        configuration.headers = headers
        configuration.timeoutIntervalForRequest = 120
        sessionManager = Session(configuration: configuration)
    }
}

// MARK: - Base request
extension RequestManager {
    private func baseCallRequest(url: URLRequestConvertible, completion: @escaping ((Any?, APIError?) -> Void)) {
        let request = self.sessionManager.request(url)
        request
            .validate(statusCode: 200..<300)
            .responseJSON(completionHandler: { (response) in
                switch response.result {
                case .success(let value):
                    self.log(request: request)
                    completion(value, nil)
                case .failure(let error):
                    if let statusCode = response.response?.statusCode, statusCode < 300, statusCode >= 200 {
                        completion(Void(), nil)
                        break
                    }
                    else {
                        guard let data = response.data else {
                            completion(nil, APIError.decodeError)
                            return
                        }
                        let messsage = try? JSONSerialization.jsonObject(with: data, options : .allowFragments)
                        self.log(request: request, error: messsage ?? "N/A")

                        if error._code == NSURLErrorTimedOut {
                            let error = APIError(code: HTTPStatusCode.code408.rawValue)
                           completion(nil, error)
                        } else {
                            guard let httpStatus = response.response?.statusCode,
                                let status = HTTPStatusCode(rawValue: httpStatus) else {
                                    completion(nil, APIError.decodeError)
                                    break
                            }
                            let error = APIError(code: status.rawValue, message: messsage)
                           completion(nil, error)
                        }
                    }
                }
            })
    }
    
    private func log(request: DataRequest, error: Any? = nil) {
        #if DEBUG
        print("\n")
        if error == nil {
            debugPrint("--------------------------------SUCCESS--------------------------------------------")
        }
        else {
            debugPrint("--------------------------------FAIL--------------------------------------------")
        }
        debugPrint(request)
        if error != nil {
            print("\n")
            print("Error msg: \(String(describing: error ?? ""))")
            print("\n")
        }
        debugPrint("--------------------------------END--------------------------------------------")
        print("\n")
        #endif
    }
}

// MARK: - Xử lý response trả về dạng json [String: Any]
extension RequestManager {
    func callRequest(url: URLRequestConvertible, completion: @escaping (([String: Any]?, APIError?) -> Void)) {
        self.baseCallRequest(url: url) { (response, error) in
            if let json = response as? [String: Any] {
                completion(json, nil)
            }
            else {
                if error != nil {
                    completion(nil, error)
                }
                else {
                    completion(nil, APIError.decodeError)
                }
            }
        }
    }

    /// Base request response Mappalbe of ObjectMapper
    func callRequest<T: Mappable>(url: URLRequestConvertible, success: ((T) -> Void)?, fail: ((APIError) -> Void)?) {
        self.callRequest(url: url) { (value, error) in
            if let json = value, let mapper = Mapper<T>().map(JSON: json) {
                success?(mapper)
            }
            else {
                if error != nil {
                    fail?(error!)
                }
                else {
                    fail?(APIError.decodeError)
                }
            }
        }
    }
}

// MARK: - Xử lý response trả về dạng json [[String: Any]]
extension RequestManager {
    func callRequestResArray(url: URLRequestConvertible, completion: @escaping (([[String: Any]]?, APIError?) -> Void)) {
        self.baseCallRequest(url: url) { (response, error) in
            if let json = response as? [[String: Any]] {
                completion(json, nil)
            }
            else {
                if error != nil {
                    completion(nil, error)
                }
                else {
                    completion(nil, APIError.decodeError)
                }
            }
        }
    }

    /// Base request response Mappalbe of ObjectMapper
    func callRequestResArray<T: Mappable>(url: URLRequestConvertible, success: (([T]) -> Void)?, fail: ((APIError) -> Void)?) {
        self.callRequestResArray(url: url) { (value, error) in
            if let json = value {
                let mapper = Mapper<T>().mapArray(JSONArray: json)
                success?(mapper)
            }
            else {
                if error != nil {
                    fail?(error!)
                }
                else {
                    fail?(APIError.decodeError)
                }
            }
        }
    }
}
