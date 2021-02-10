//
//  TargetType+Header.swift
//  ios_MVVM
//
//  Created by Candra Restu on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
    func defaultHeader() -> HTTPHeaders {
        var headers: [String: String] = [:]

        let langStr = Locale.preferredLanguages[0]
        let arr = langStr.components(separatedBy: "-")
        let deviceLanguage = arr.first
        headers["Content-Type"] = "application/json"

        return headers
    }
}
