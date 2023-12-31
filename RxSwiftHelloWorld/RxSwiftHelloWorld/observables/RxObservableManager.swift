//
//  RxObservableManager.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/26.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

class RxObservableManager {
    static let shared = RxObservableManager()
    var observable: Observable<String>?
    init() {
        let _ = observable?.subscribe(onNext: { (element) in
            print("==\(element)==")
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("onCompleted")
        }, onDisposed: {
            print("onDisposed")
        })
    }
    func createAction() {
        
    }
}
