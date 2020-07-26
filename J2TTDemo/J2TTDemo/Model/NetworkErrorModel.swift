//
//  NetworkErrorModel.swift
//  J2TTDemo
//
//  Created by Sagar on 25/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation

struct NetworkErrorModel {
    var networkStatusType: NetworkError = .somethingWentWrong
    var error: Error?
    var statusCode: Int? = 200
    var message: String?
}
