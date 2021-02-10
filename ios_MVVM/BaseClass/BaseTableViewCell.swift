//
//  BaseTableViewCell.swift
//  ios_MVVM
//
//  Created by Candra Restu on 09/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        selectionStyle = .none
        initView()
    }
    
    func initView() {
    }
    
    static var identifier: String {
        return String(describing: self)
    }
}
