//
//  ResponseHandler.swift
//  ios_MVVM
//
//  Created by Candra Restu on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
import Moya

class ResponseHandler {

    static func getResponse<T : Decodable> (data: Data) -> T? {
        do {
            let response = try JSONDecoder().decode(T.self, from: data)
            return response
        } catch let error {
            print("error: \(error)")
        }
        return nil
    }
}
