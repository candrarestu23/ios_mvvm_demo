//
//  BaseResponseModel.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
struct BaseResponseModel: Codable {
    var data: HomeDataModel?
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    init(data: HomeDataModel){
        self.data = data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        data = try container.decodeIfPresent(HomeDataModel.self, forKey: .data)
    }
}
