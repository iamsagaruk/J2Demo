//
//  NetworkClient.swift
//  J2TTDemo
//
//  Created by Sagar on 25/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//


import UIKit
import Alamofire

typealias NetworkCompletionHandler = (_ isSuccess: Bool, _ response: Any?, _ errorModel: NetworkErrorModel?) -> Void

let apiTimeOut = 180.0
let authorizationKey = "Authorization"

class NetworkAdapter: RequestAdapter {
    private var requestsToRetry: [RequestRetryCompletion] = []

    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        return urlRequest
    }
}

class NetworkClient: NSObject {
    static let sharedClient = NetworkClient()
    var manager: SessionManager!

    private override init() {
        super.init()
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = apiTimeOut
        manager = Alamofire.SessionManager(configuration: configuration)
        manager.adapter = NetworkAdapter()
    }

    func getConfigureHeader(from headers: [String: String]?) -> HTTPHeaders {
        var commonHeader: [String: String] = Alamofire.SessionManager.defaultHTTPHeaders as Dictionary
        
        if let headers = headers {
            for (key, value) in headers {
                commonHeader[key] = value
            }
        }
        return commonHeader
    }

    func sendGetRequest(_ urlStr: String, httpMethod: HTTPMethod = .get, parameters: [String: Any]?, headers: [String: String]?, networkCompletionHandler: @escaping NetworkCompletionHandler) {
        //debugPrint("params: ", parameters ?? "no params")
        
        if let encodedString = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: encodedString) {
                let configuredHeader = getConfigureHeader(from: headers)

                manager.request(url, method: httpMethod, parameters: parameters, encoding: URLEncoding.default, headers: configuredHeader)
                    .validate(statusCode: 200..<300)
                    .validate(contentType: ["application/json", "text/html"])
                    .responseJSON { [weak self] (response) in
                        self?.handleNetworkResponse(response: response, networkCompletionHandler: networkCompletionHandler)
                }
            }
        }
    }

    func handleNetworkResponse(response: DataResponse<Any>, networkCompletionHandler: NetworkCompletionHandler) {
        switch response.result {
        case .success(let json):
            //debugPrint("response:", json)
            networkCompletionHandler(true, json, nil)
        case .failure(let error):
            let errorModel = configureErrorModel(for: response, error: error)
            networkCompletionHandler(false, nil, errorModel)
        }
    }

    func configureErrorModel(for response: DataResponse<Any>, error: Error?) -> NetworkErrorModel {
        var errorModel = NetworkErrorModel()
        errorModel.statusCode = response.response?.statusCode
        errorModel.error = error
        if response.response != nil {
            //Handle Error Data Response
            errorModel.networkStatusType = NetworkError.somethingWentWrong
        } else {
            errorModel.networkStatusType = NetworkError.timeOut
        }
        return errorModel
    }
}
