//
//  HomePageViewModel.swift
//  ios_MVVM
//
//  Created by Candra Restu on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import CoreData

class HomePageViewModel {
    private let disposeBag = DisposeBag()
    private let provider = MoyaProvider<HomePageService>()
    let data = ObservableData<HomeDataModel>()
    let isLoading = ObservableData<Bool>()
    let errorMessage = ObservableData<String>()
    let localData = ObservableData<[ProductListItem]>()
    
    func getData() {
        isLoading.value = true
        provider.rx.request(.getHomeData)
            .map([BaseResponseModel].self)
            .subscribe { [weak self] (event) in
                guard let self = self else { return }
                self.isLoading.value = false
                switch event {
                case .success(let response):
                    if let data = response.first?.data {
                        self.data.value = data
                    }
                case .error(let error):
                    print(error.localizedDescription)
                    self.errorMessage.value = error.localizedDescription
                }
        }.disposed(by: disposeBag)
    }
    
    func getLocalData(context: NSManagedObjectContext){
        do {
            localData.value = try context.fetch(ProductListItem.fetchRequest())
        } catch {
            print("get data error")
        }
    }
    
    func saveData(context: NSManagedObjectContext, promoDataList: [ProductPromoDataModel]){
        for data in promoDataList {
            let newData = NSEntityDescription.insertNewObject(forEntityName: "ProductListItem", into: context)
            newData.setValue(data.id ?? "", forKey: "id")
            newData.setValue(data.imageUrl ?? "", forKey: "imageUrl")
            newData.setValue(data.loved ?? 0, forKey: "loved")
            newData.setValue(data.price ?? "", forKey: "price")
            newData.setValue(data.title ?? "", forKey: "title")
        }
        
        do {
            try context.save()
        } catch {
            print("save data error")
        }
    }
    
    func deleteAllData(context: NSManagedObjectContext){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ProductListItem")
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                guard let objectData = object as? NSManagedObject else {continue}
                context.delete(objectData)
            }
        } catch let error {
            print("Detele all data in ProductListItem error :", error)
        }
    }
}
