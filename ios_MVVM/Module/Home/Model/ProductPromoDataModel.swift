//
//  ProductPromoDataModel.swift
//  ios_MVVM
//
//  Created by Candra Restu on 09/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation

struct ProductPromoDataModel: Codable {
    var id: String?
    var imageUrl: String?
    var title: String?
    var description: String?
    var price: String?
    var loved: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageUrl
        case title
        case description
        case price
        case loved
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(String.self, forKey: .id)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        price = try container.decodeIfPresent(String.self, forKey: .price)
        loved = try container.decodeIfPresent(Int.self, forKey: .loved)
    }
}
