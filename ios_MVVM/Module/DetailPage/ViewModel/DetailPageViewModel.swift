//
//  DetailPageViewModel.swift
//  ios_MVVM
//
//  Created by Iglo-macpro on 11/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
import RxSwift
import CoreData

class DetailPageViewModel {
    private let disposeBag = DisposeBag()
    let localData = ObservableData<[HistoryProductLIstItem]>()
    let saveSuccess = ObservableData<Bool>()
    func getLocalData(context: NSManagedObjectContext){
        do {
            localData.value = try context.fetch(HistoryProductLIstItem.fetchRequest())
        } catch {
            print("get data error")
        }
    }
    
    func saveData(context: NSManagedObjectContext, promoDataList: ProductPromoDataModel){
        let newData = NSEntityDescription.insertNewObject(forEntityName: "HistoryProductLIstItem", into: context)
        newData.setValue(promoDataList.id ?? "", forKey: "id")
        newData.setValue(promoDataList.imageUrl ?? "", forKey: "imageUrl")
        newData.setValue(promoDataList.loved ?? 0, forKey: "loved")
        newData.setValue(promoDataList.price ?? "", forKey: "price")
        newData.setValue(promoDataList.title ?? "", forKey: "title")
        
        do {
            try context.save()
            saveSuccess.value = true
        } catch {
            saveSuccess.value = false
            print("save data error")
        }
    }
    
    func deleteAllData(context: NSManagedObjectContext){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "HistoryProductLIstItem")
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
