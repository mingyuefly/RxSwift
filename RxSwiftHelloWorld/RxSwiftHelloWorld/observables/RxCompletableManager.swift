//
//  RxCompletableManager.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/12/7.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

enum MyError: Error {
  case error1((Int, String))
  case error2((Int, String))
  case error3((Int, String)) 
}

class RxCompletableManager {
    static let shared = RxCompletableManager()
    func cacheLocally() -> Completable {
        return Completable.create { completable in
            var success = true
            success = false
            guard success else {
                completable(.error(MyError.error1((101, "Completable error"))))
                return Disposables.create {}
            }
            completable(.completed)
            return Disposables.create {}
        }
    }
}
