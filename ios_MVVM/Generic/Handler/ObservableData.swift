//
//  ObservableData.swift
//  ios_MVVM
//
//  Created by Candra Restu on 10/02/21.
//  Copyright © 2021 candra-portofolio. All rights reserved.
//

import Foundation
import RxSwift

class ObservableData<DATA> {
    var value: DATA? = nil {
        didSet {
            observers.onNext(value)
        }
    }
    
    private let observers = PublishSubject<DATA?>()
    
    init(_ data: DATA? = nil) {
        self.value = data
    }
    
    func observe(_ disposeBag: DisposeBag, observer:  @escaping (DATA?) -> Void) {
        observers
            .subscribe(onNext: observer, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
    }
}
