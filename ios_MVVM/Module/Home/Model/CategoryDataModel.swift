//
//  CategoryDataModel.swift
//  ios_MVVM
//
//  Created by Candra Restu on 09/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation

struct CategoryDataModel: Codable {
    var imageUrl: String?
    var id: Int?
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case imageUrl
        case id
        case name
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        imageUrl = try container.decodeIfPresent(String.self, forKey: .imageUrl)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
}
