//
//  HomeDataModel.swift
//  ios_MVVM
//
//  Created by Candra Restu on 09/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation

struct HomeDataModel: Codable {
    var category: [CategoryDataModel]?
    var productPromo: [ProductPromoDataModel]?
    
    enum CodingKeys: String, CodingKey {
        case category
        case productPromo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        category = try container.decodeIfPresent([CategoryDataModel].self, forKey: .category)
        productPromo = try container.decodeIfPresent([ProductPromoDataModel].self, forKey: .productPromo)
    }
}
