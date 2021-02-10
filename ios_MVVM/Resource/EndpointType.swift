//
//  EnpointType.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 09/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation

public typealias Parameters = [String: Any]
public typealias HTTPHeaders = [String: String]

public enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol EndpointType {
    var method: HTTPMethod { get }
    var endPoint: String { get }
    var path: String { get }
    var param: Parameters { get }
    var header: HTTPHeaders { get }
    var isAlertActive: Bool { get }
}

extension EndpointType {
    func defaultHeader() -> HTTPHeaders {
        let langStr = Locale.preferredLanguages[0]
        let arr = langStr.components(separatedBy: "-")
        let deviceLanguage = arr.first

        var headers: [String: String] = [:]
        headers["Content-Type"] = "application/json"
        return headers
    }

//    func buildURLRequest() throws -> URLRequest? {
//        guard let url = URL(string: "\(Constant.baseURL)\(endPoint)")?.appendingPathComponent(path) else {
//            throw ApiNetworkingError.missingUrl
//        }
//        var urlRequest = URLRequest(url: url)
//        urlRequest.allHTTPHeaderFields = header
//        urlRequest.httpMethod = method.rawValue
//
//        do {
//            switch method {
//            case .post, .patch:
//                urlRequest.httpBody = try JSON(param).rawData(options: .prettyPrinted)
//            case .get, .delete, .put:
//                try URLParameterEncoder().encode(urlRequest: &urlRequest, with: param)
//            }
//        } catch {
//            throw ApiNetworkingError.encodingFailure
//        }
//
//        return urlRequest
//    }
}

//public struct URLParameterEncoder {
//    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
//        guard let url = urlRequest.url else { throw ApiNetworkingError.missingUrl }
//        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
//
//        if !parameters.isEmpty {
//            urlComponents?.queryItems = [URLQueryItem]()
//
//            for (key, value) in parameters {
//                let queryItem = URLQueryItem(name: key,
//                                             value: "\(value)")
//                urlComponents?.queryItems?.append(queryItem)
//            }
//        }
//
//        urlRequest.url = urlComponents?.url
//    }
//}
