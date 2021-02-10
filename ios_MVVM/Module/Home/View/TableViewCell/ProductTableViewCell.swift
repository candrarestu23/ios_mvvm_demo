//
//  ProductTableViewCell.swift
//  ios_MVVM
//
//  Created by Candra Restu on 09/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import SkeletonView

class ProductTableViewCell: BaseTableViewCell {
 
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var heartImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    var didTapItem: EmptyClosure?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onImageTap(tapGesture:)))
        itemImageView.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @objc func onImageTap(tapGesture: UITapGestureRecognizer){
        didTapItem?()
    }
    
}
