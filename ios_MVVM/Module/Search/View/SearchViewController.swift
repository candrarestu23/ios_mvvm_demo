//
//  SearchViewController.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import RxSwift
import Kingfisher

class SearchViewController: UIViewController {
    
    @IBOutlet weak var tableVIew: UITableView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let searchBarWidth = UIScreen.main.bounds.width - 100
    lazy var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: searchBarWidth, height: 60))
    var viewModel = HomePageViewModel()
    private let disposable = DisposeBag()
    var data: [ProductListItem]?
    var filteredData: [ProductListItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
        initViewModel()
        viewModel.getLocalData(context: context)
    }
    
    private func setupSearchBar(){
        searchBar.placeholder = "Search"
        searchBar.delegate = self
        let rightBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setupTableView(){
        tableVIew.register(nibWithCellClass: SearchTableViewCell.self)
        tableVIew.delegate = self
        tableVIew.dataSource = self
    }
    
    private func initViewModel(){
        viewModel.localData.observe(disposable) { (data) in
            guard let data = data else { return }
            self.data = data
            self.filteredData = data
            DispatchQueue.main.async {
                self.tableVIew.reloadData()
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.filteredData.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withClass: SearchTableViewCell.self) as? SearchTableViewCell else { return UITableViewCell()}
        cell.itemPriceLabel.text = filteredData[indexPath.row].price
        cell.itemNameLabel.text = filteredData[indexPath.row].title
        cell.itemImageView.kf.setImage(with: filteredData[indexPath.row].imageUrl?.toUrl)
        return cell
    }
    
    
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let data = self.data else { return }
        if searchText.isEmpty == false {
            filteredData = data.filter({ ($0.title?.contains(searchText) ?? false) })
        } else {
            if let data = self.data {
                filteredData = data
            }
        }
        
        tableVIew.reloadData()
    }
}
