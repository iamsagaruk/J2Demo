//
//  ArticleUseCase.swift
//  J2TTDemo
//
//  Created by Sagar on 25/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation
import ObjectMapper

typealias DataParsedCompletionHandler = (_ isSuccess: Bool, _ response: Any?, _ error: NetworkErrorModel?) -> Void

public class ArticleUseCase {
    static let sharedUseCase = ArticleUseCase()

    func getArticleDetails(completionHandler: @escaping DataParsedCompletionHandler) {
        NetworkClient.sharedClient.sendGetRequest(AppConstant.kFetchArticleUrl , httpMethod: .get, parameters: nil, headers: nil) { (isSuccess, response, error) in
            if isSuccess {
                let articleList = Mapper<ArticleResponse>().mapArray(JSONObject: response)
                completionHandler(isSuccess, articleList, nil)
            } else {
                completionHandler(false, nil, error)
            }
        }
    }
}
