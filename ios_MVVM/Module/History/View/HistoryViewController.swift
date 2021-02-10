//
//  HistoryViewController.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import UIKit
import CoreData
import RxSwift

class HistoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var data: [HistoryProductLIstItem] = []
    var viewModel = DetailPageViewModel()
    private let disposable = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Purchase History"
        setupTableView()
        initViewModel()
        viewModel.getLocalData(context: context)
    }
    
    private func setupTableView() {
        tableView.register(nibWithCellClass: SearchTableViewCell.self)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func initViewModel() {
        viewModel.localData.observe(disposable) { (data) in
            guard let data = data else { return }
            self.data = data
            self.tableView.reloadData()
        }
    }
}

extension HistoryViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withClass: SearchTableViewCell.self) as? SearchTableViewCell else { return UITableViewCell()}
        cell.itemPriceLabel.text = data[indexPath.row].price
        cell.itemNameLabel.text = data[indexPath.row].title
        cell.itemImageView.kf.setImage(with: data[indexPath.row].imageUrl?.toUrl)
        return cell
    }
    
    
}

extension HistoryViewController: UITableViewDelegate {
    
}
