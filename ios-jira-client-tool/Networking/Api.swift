//
//  Api.swift
//  ios-jira-client-tool
//
//  Created by Tung Nguyen on 9/23/19.
//  Copyright © 2019 Tung Nguyen. All rights reserved.
//

import Foundation

class Api: NetworkRouter {
    
    static let baseURL = "https://jira.teko.vn"
    
    private var task: URLSessionTask?
    
    var session = URLSession.shared
    
    enum Endpoint: String {
        case testrun = "/rest/atm/1.0/testrun"
        case testcase = "/rest/atm/1.0/testcase"
        case testcaseSearch = "/rest/atm/1.0/testcase/search"
    }
    
    func buildRequest(params: Parameters = [:],
                      to endpoint: String,
                      method: HTTPMethod = .get,
                      token: String? = nil,
                      headers: HTTPHeaders? = nil) throws -> URLRequest? {
        var urlComponents = URLComponents(string: Api.baseURL + endpoint)!
        urlComponents.queryItems = params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        var request = URLRequest(url: urlComponents.url!,
                                 cachePolicy: .reloadIgnoringLocalAndRemoteCacheData,
                                 timeoutInterval: 10.0)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        headers?.forEach({ request.setValue($0.value, forHTTPHeaderField: $0.key) })
        return request
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> NetworkResult<String> {
        switch response.statusCode {
        case 200...299: return .success
        case 401...500: return .failure(NetworkResponse.authenticationError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    func execute(request: URLRequest, completion: @escaping NetworkRouterCompletion) {
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            completion(data, response, error)
        })
        self.task?.resume()
    }
    
    func cancel() {
        self.task?.cancel()
    }
    
    func request(endpoint: String, params: Parameters = [:], completion: @escaping (Response?, String?) -> Void) {
        do {
            let request = try buildRequest(params: params, to: endpoint)!
            execute(request: request) { (data, response, error) in
                if let error = error {
                    switch error {
                    case URLError.timedOut, URLError.cannotConnectToHost:
                        completion(nil, NetworkResponse.timeOut.message)
                    case URLError.notConnectedToInternet:
                        completion(nil, NetworkResponse.notConnectedToInternet.message)
                    case URLError.networkConnectionLost:
                        completion(nil, NetworkResponse.networkConnectionLost.message)
                    default:
                        completion(nil, "Có lỗi khi kết nối tới máy chủ")
                    }
                    return
                }
                if let response = response as? HTTPURLResponse {
                    let result = self.handleNetworkResponse(response)
                    switch result {
                    case .success:
                        guard let responseData = data else {
                            completion(nil, NetworkResponse.noData.rawValue)
                            return
                        }
                        do {
                            let reponse = try JSONDecoder().decode(Response?.self, from: responseData)
                            completion(reponse, nil)
                        } catch {
                            completion(nil, NetworkResponse.unableToDecode.rawValue)
                        }
                    case .failure(let networkFailureError):
                        completion(nil, networkFailureError)
                    }
                } else {
                    completion(nil, NetworkResponse.noData.rawValue)
                }
            }
        } catch {
            completion(nil, error.localizedDescription)
        }
    }
    
    func createTestCase(authorization: String,
                        projectKey: String,
                        folder: String,
                        issueKey: String,
                        testCase: TestCase,
                        completion: @escaping (Response?, String?) -> ()) throws {
        
        let headers: HTTPHeaders = ["Authorization": "Basic " + authorization]
        var dict: [String: Any] = [:]
        
        dict["projectKey"] = projectKey
        dict["name"] = testCase.identifier
        dict["status"] = "Approved"
//        dict["folder"] = folder
        dict["issueLinks"] = [issueKey]
        
        var request = try buildRequest(params: [:],
                                   to: Endpoint.testcase.rawValue,
                                   method: .post,
                                   token: nil,
                                   headers: headers)
        
        request?.httpBody = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        execute(request: request!) { (data, response, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
            }
            let res = String(data: data!, encoding: .utf8)
            print(res)
            guard let data = data, let response = try? JSONDecoder().decode(Response.self, from: data) else {
                completion(nil, "Cannot decode response")
                return
            }
            completion(response, nil)
        }
    }
    
    func createTestCycle(authorization: String,
                         projectKey: String,
                         cycleName: String,
                         folder: String,
                         issueKey: String,
                         testCases: [TestCase],
                         completion: @escaping (Response?, String?) -> ()) throws {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-ddThh:mm:ssZ"
        
        let items = testCases.map { c -> TestItem in
            let testItem = TestItem()
            testItem.executionDate = dateFormatter.string(from: Date())
            testItem.status = c.status
            testItem.testCaseKey = c.key
            return testItem
        }
        
        let headers: HTTPHeaders = ["Authorization": "Basic " + authorization]
        
        var dict: [String: Any] = [:]
        
        let itemsDict = items.map { $0.dict }
        
        dict["projectKey"] = projectKey
        dict["items"] = itemsDict
        dict["name"] = cycleName
//        dict["folder"] = folder
        dict["issueKey"] = issueKey
        
        var request = try buildRequest(params: [:],
                                   to: Endpoint.testrun.rawValue,
                                   method: .post,
                                   token: nil,
                                   headers: headers)
        
        request?.httpBody = try? JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
        
        execute(request: request!) { (data, response, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
            }
            let res = String(data: data!, encoding: .utf8)
            print(res)
            guard let data = data, let response = try? JSONDecoder().decode(Response.self, from: data) else {
                completion(nil, "Cannot decode response")
                return
            }
            completion(response, nil)
        }
        
    }
    
    func findTestCase(authorization: String, projectKey: String, name: String, completion: @escaping ([JIRATestCase]?, String?) -> ()) throws {
        let headers: HTTPHeaders = ["Authorization": "Basic " + authorization]
        let query = "projectKey = \"\(projectKey)\" AND name = \"\(name)\""

        let request = try? buildRequest(params: ["query": query],
                                   to: Endpoint.testcaseSearch.rawValue,
                                   method: .get,
                                   token: nil,
                                   headers: headers)
        execute(request: request!) { (data, response, error) in
            if let error = error {
                completion(nil, error.localizedDescription)
            }
            guard let data = data, let cases = try? JSONDecoder().decode([JIRATestCase].self, from: data) else {
                completion(nil, "Cannot decode response")
                return
            }
            completion(cases, nil)
        }
    }
    
}
