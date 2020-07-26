//
//  ArticleViewModel.swift
//  J2TTDemo
//
//  Created by Sagar on 25/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation
import ObjectMapper

class ArticleViewModel {
    static let sharedArticleVM = ArticleViewModel()
    var articleList: [ArticleResponse]?

    func getArticleDetails(completionHandler: @escaping DataParsedCompletionHandler) {
        ArticleUseCase.sharedUseCase.getArticleDetails { [weak self] (isSuccess, response , errorModel) in
            if isSuccess {
                self?.articleList = response as? [ArticleResponse] ?? []
                completionHandler(isSuccess, response, nil)
            } else {
                completionHandler(false, nil, errorModel)
            }
        }
    }
}

