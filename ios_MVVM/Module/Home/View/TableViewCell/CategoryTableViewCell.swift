//
//  CategoryTableViewCell.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import SkeletonView

class CategoryTableViewCell: BaseTableViewCell {

    @IBOutlet weak var categoryCollectionView: BaseCollectionView!
    var data: [CategoryDataModel]? {
        didSet {
            categoryCollectionView.reloadData()
        }
    }
    var isLoading = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCollectionView(){

        categoryCollectionView.dataSource = self
        categoryCollectionView.delegate = self
        categoryCollectionView.showsHorizontalScrollIndicator = false
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    }
    
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withClass: CategoryCollectionViewCell.self, for: indexPath) as? CategoryCollectionViewCell else { return UICollectionViewCell() }
        if self.isLoading {
            cell.categoryLabel.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .clouds), transition: .crossDissolve(0.25))
            cell.categoryImageView.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .clouds), transition: .crossDissolve(0.25))
        } else {
            cell.categoryLabel.hideSkeleton(transition: .crossDissolve(0.25))
            cell.categoryImageView.hideSkeleton(transition: .crossDissolve(0.25))
        }
        
        if let data = self.data {
            cell.categoryLabel.text = data[indexPath.row].name ?? ""
            cell.categoryImageView.kf.setImage(with: data[indexPath.row].imageUrl?.toUrl)
        }
        return cell
    }
    
    
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        let width: CGFloat = 120
        let height: CGFloat = 132
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumLineSpacingForSectionAt _: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, minimumInteritemSpacingForSectionAt _: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, insetForSectionAt _: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    }
    
}
