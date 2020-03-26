//
//  Food.swift
//  FetchYelpApi
//
//  Created by Keapheng on 3/20/20.
//  Copyright © 2020 Keapheng. All rights reserved.
//

import Foundation
import Moya

private let token = "RS_ejB5hN_TSuUrXIedqjHvmwdoiVj5az_7iX8M5K7cZ2Ok7tMGpRSfjl4jyR24zC7_dj85Yp4zOUy6B1Q58CDBssRo1lFmW8ovVsf4_P2aXoM2Qc0cGYb8rItzAXXYx"


enum Food {
    case foodRequest(term: String)
}

extension Food:  TargetType {
    var baseURL: URL {
        switch self {
        case .foodRequest:
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
    }
    
    var path: String {
        switch self {
        case .foodRequest:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .foodRequest:
            return .get
        }
    }
    
    var parameterEcoding: ParameterEncoding {
        switch self {
        case .foodRequest:
            return URLEncoding.queryString
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .foodRequest(let term):
//            ?term=pasta&location='san jose'&limit=50
        let params: [String: Any] = ["term": term, "location": "san jose", "limit": 50]
        return .requestParameters(parameters: params, encoding: parameterEcoding)
//        return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(token)"]
    }
    
    
}
