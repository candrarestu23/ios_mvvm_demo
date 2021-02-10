//
//  ApiService+URLSession.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//
//
//import Foundation
//class URLSessionAPIService: APIService {
//    private var session: URLSession
//
//    required init(session: URLSession = URLSession.shared) {
//        self.session = URLSession(configuration: .default, delegate: SSLPinningURLSessionDelegate(), delegateQueue: nil)
//    }
//
//    func executeApi(route: EndpointType, completion: @escaping (Result<Data, ApiNetworkingError>) -> Void) -> APIServiceTask? {
//        do {
//            guard let request = try route.buildURLRequest() else {
//                completion(.failure(ApiNetworkingError.missingUrl))
//                return nil
//            }
//
//            let task = session.dataTask(with: request, completionHandler: { data, response, error in
//                let result = self.URLSessionErrorChecking(data, response, error, route.isAlertActive)
//
//                switch result {
//                case let .success(data):
//                    DispatchQueue.main.async {
//                        completion(.success(data))
//                    }
//                case let .failure(networkingErr):
//                    DispatchQueue.main.async {
//                        completion(.failure(networkingErr))
//                    }
//                }
//            })
//            return task
//        } catch {
//            DispatchQueue.main.async {
//                completion(.failure(ApiNetworkingError.failedBuildRequest))
//            }
//        }
//        return nil
//    }
//
//    func executeApi<T>(route: EndpointType, with model: T.Type, completion: @escaping (Result<T, ApiNetworkingError>) -> Void) -> APIServiceTask? where T: Decodable, T: Encodable {
//        do {
//            guard let request = try route.buildURLRequest() else {
//                completion(.failure(ApiNetworkingError.missingUrl))
//                return nil
//            }
//
//            let task = session.dataTask(with: request, completionHandler: { data, response, error in
//                let result = self.URLSessionErrorChecking(data, response, error, route.isAlertActive)
//
//                switch result {
//                case let .success(data):
//                    let decodeResult = dataDecode(model: model, data: data)
//                    DispatchQueue.main.async {
//                        completion(decodeResult)
//                    }
//                case let .failure(networkingErr):
//                    DispatchQueue.main.async {
//                        completion(.failure(networkingErr))
//                    }
//                }
//            })
//            return task
//        } catch {
//            DispatchQueue.main.async {
//                completion(.failure(ApiNetworkingError.failedBuildRequest))
//            }
//        }
//        return nil
//    }
//}
//
//extension URLSessionTask: APIServiceTask {
//    func start() {
//        resume()
//    }
//}
//
//extension URLSessionAPIService {
//    // MARK: Successful Api Code Checking
//
//    private func hasSuccessfulApiCode(_ value: String) -> Bool {
//        return ["00", "200", "99"].contains(value)
//    }
//
//    // MARK: Response Error Checking
//
//    func URLSessionErrorChecking(_ data: Data?,
//                                 _ response: URLResponse?,
//                                 _ error: Error?,
//                                 _ alert: Bool = true) -> Result<Data, ApiNetworkingError> {
//        if let response = response as? HTTPURLResponse {
//            let result = handleNetworkResponse(data,
//                                               response,
//                                               error: error,
//                                               alert: alert)
//            return result
//        }
//
//        if let err = error as NSError?, err.code == NSURLErrorCancelled {
//            return .failure(.certificateInvalid)
//        }
//
//        return .failure(ApiNetworkingError.emptyResponse)
//    }
//
//    func handleNetworkResponse(_ data: Data?, _ response: HTTPURLResponse?, error: Error?, alert: Bool = true) -> Result<Data, ApiNetworkingError> {
//        guard let response = response else {
//            return .failure(ApiNetworkingError.emptyResponse)
//        }
//
//        if let error = error {
//            return fatalErrorChecking(error, response)
//        }
//
//        if response.statusCode == 401 {
//            return .failure(ApiNetworkingError.sessionExpired)
//
//        } else if response.statusCode == 403 {
//            return .failure(ApiNetworkingError.forceCloseApp)
//
//        } else if response.statusCode == 500 {
//            return .failure(ApiNetworkingError.internalServerError)
//        }
//
//        guard let responseData = data else { return .failure(ApiNetworkingError.emptyData) }
//
//        guard response.statusCode < 299 else {
//            return errorBodyResponseChecking(responseData, alert)
//        }
//
//        return .success(responseData)
//    }
//
//    func errorBodyResponseChecking(_ responseData: Data, _: Bool) -> Result<Data, ApiNetworkingError> {
//        let json = JSON(responseData)
//
//        guard let code = json["code"].string,
//            let message = json["message"].string,
//            !hasSuccessfulApiCode(code) else {
//            if let code = json["status"].int, code > 299 {
//                let message: String = json["message"].stringValue + " " + json["error"].stringValue
//                return .failure(ApiNetworkingError.errorWithMessage(message: message))
//            }
//
//            if let message = json["message"].string {
//                return .failure(ApiNetworkingError.errorWithMessage(message: message))
//            }
//
//            return .failure(ApiNetworkingError.undefined)
//        }
//
//        if json["errorFields"].arrayValue.count > 0 {
//            let decodedData = dataDecode(model: StatusResponse.self, data: responseData)
//
//            switch decodedData {
//            case let .success(data):
//                return .failure(ApiNetworkingError.formValidationError(message: data.message ?? Strings.General.emptyString, errorFields: data.errorFields ?? []))
//            case let .failure(error):
//                return .failure(error)
//            }
//        }
//
//        return .failure(ApiNetworkingError.errorWithMessage(message: message))
//    }
//
//    func fatalErrorChecking(_ error: Error, _ response: HTTPURLResponse) -> Result<Data, ApiNetworkingError> {
//        // force logout if getting 403 forbidden
//        switch response.statusCode {
//        case 401:
//            return .failure(ApiNetworkingError.loginWithAnotherDevice)
//        case 403:
//            return .failure(ApiNetworkingError.forceCloseApp)
//        case 428:
//            return .failure(ApiNetworkingError.optionalUpdate)
//        case 426:
//            return .failure(ApiNetworkingError.outOfDateApps)
//        case -999:
//            return .failure(ApiNetworkingError.errorWithMessage(message: error.localizedDescription))
//        default:
//            return .failure(ApiNetworkingError.undefined)
//        }
//    }
//}
//
//// MARK: Json Data Decode
//
//func dataDecode<T: Codable>(model: T.Type, data: Data?) -> Result<T, ApiNetworkingError> {
//    if let dataResponse = data {
//        do {
//            let decodedData = try JSONDecoder().decode(model.self, from: dataResponse)
//            return .success(decodedData)
//        } catch {
//            return .failure(ApiNetworkingError.decodingFailure)
//        }
//    }
//
//    return .failure(ApiNetworkingError.emptyData)
//}
