//
//  Http.swift
//  ios-jira-client-tool
//
//  Created by Tung Nguyen on 9/24/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

enum NetworkResponse: String {
    case success
    case authenticationError = "Chưa đăng nhập"
    case badRequest = "Bad request"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
    case timeOut = "Timeout"
    case notConnectedToInternet = "notConnectedToInternet"
    case networkConnectionLost = "networkConnectionLost"
    
    var message: String? {
        return self.rawValue
    }
    
}

enum NetworkResult<String> {
    case success
    case failure(String)
}

public typealias HTTPHeaders = [String: String]
public typealias Parameters = [String: String]
public typealias NetworkRouterCompletion = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> ()

protocol NetworkRouter: class {
    func execute(request: URLRequest, completion: @escaping NetworkRouterCompletion)
    func cancel()
}
