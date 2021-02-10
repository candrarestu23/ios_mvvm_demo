//
//  String+Ext.swift
//  ios_MVVM
//
//  Created by Candra Restu on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation

extension String {
    var toUrl: URL? {
        guard let encoded = addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) else { return nil }
        return URL(string: encoded)
    }
}
