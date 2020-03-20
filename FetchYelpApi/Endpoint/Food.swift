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
    case foodRequest
}

extension Food: TargetType {
    var baseURL: URL {
        switch self {
        case .foodRequest:
            return URL(string: "https://api.yelp.com/v3/businesses")!
        }
    }
    
    var path: String {
        switch self {
        case .foodRequest:
            return "/search?term=pasta&location='san jose'&limit=50"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .foodRequest:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .foodRequest:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "Bearer \(token)"]
    }
    
    
}
