//
//  HomeViewController.swift
//  ios_MVVM
//
//  Created by Candra Restu on 04/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher
import CoreData
import SkeletonView

class HomeViewController: UIViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    enum SectionType: Int, CaseIterable {
        case category = 0
        case products = 1
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
    var viewModel = HomePageViewModel()
    private let disposable = DisposeBag()
    var data: HomeDataModel?
    var sections: [SectionType] = []
    var isLaoding = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isToolbarHidden = true
        searchBar.placeholder = "Your placeholder"
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
        setupTableView()
        initViewModel()
        DispatchQueue.global(qos: .background).async {
            self.viewModel.getData()
        }
        viewModel.deleteAllData(context: context)
    }
    
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: ProductTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ProductTableViewCell.identifier)
        tableView.register(UINib(nibName: CategoryTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: CategoryTableViewCell.identifier)
    }
    
    private func initViewModel(){
        viewModel.isLoading.observe(disposable) { (data) in
            guard let isLoading = data else { return }
            self.isLaoding = isLoading
        }
        
        viewModel.data.observe(disposable) { (data) in
            guard let data = data else { return }
            self.data = data
            DispatchQueue.main.async {
                self.tableView.reloadData()
                if let promoDataList = data.productPromo {
                    self.viewModel.saveData(context: self.context, promoDataList: promoDataList)
                }
            }
        }
        
        viewModel.localData.observe(disposable) { (data) in
            guard let data = data else { return }
            
        }
        
        viewModel.errorMessage.observe(disposable) { (data) in
            guard let message = data else { return }
            self.viewModel.getLocalData(context: self.context)
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 132 : UITableView.automaticDimension
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return isLaoding == true ? 8 : self.data?.productPromo?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch SectionType.allCases[indexPath.section] {
        case .category:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier) as? CategoryTableViewCell else { return UITableViewCell() }
            if let data = self.data?.category {
                cell.data = data
                cell.isLoading = self.isLaoding
            }
            return cell
        case .products:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.identifier) as? ProductTableViewCell else { return UITableViewCell() }
            if self.isLaoding {
                cell.itemImageView.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .clouds), transition: .crossDissolve(0.25))
                cell.productNameLabel.showAnimatedGradientSkeleton(usingGradient: SkeletonGradient(baseColor: .clouds), transition: .crossDissolve(0.25))
            } else {
                cell.itemImageView.hideSkeleton(transition: .crossDissolve(0.25))
                cell.productNameLabel.hideSkeleton(transition: .crossDissolve(0.25))
            }
            
            if let data = self.data?.productPromo {
                let likeStatus = data[indexPath.row].loved ?? 0
                let imageStatus = likeStatus == 0 ? UIImage(systemName: "heart") : UIImage(systemName: "heart.fill")
                cell.heartImageView.image = imageStatus
                cell.productNameLabel.text = data[indexPath.row].title
                cell.itemImageView.kf.setImage(with: data[indexPath.row].imageUrl?.toUrl)
                cell.didTapItem = { [weak self] in
                    let viewController = DetailPageViewController()
                    viewController.data = data[indexPath.row]
                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            }
            return cell
        }
    }
}
