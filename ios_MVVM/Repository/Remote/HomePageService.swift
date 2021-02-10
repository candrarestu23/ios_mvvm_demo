//
//  HomePageService.swift
//  ios_MVVM
//
//  Created by Candra Restu on 09/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Moya

enum HomePageService {
    case getHomeData
}

extension HomePageService: TargetType {
    
    var baseURL: URL {
        switch self {
        case .getHomeData:
            return URL(string: Constant.baseURL)!
        }
    }

    var path: String {
        switch self {
        case .getHomeData:
            return "home"
        }
    }

    var method: Moya.Method {
        switch self {
        case .getHomeData: return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getHomeData:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        let headers: HTTPHeaders = defaultHeader()
        return headers
    }
}
