//
//  RxObservableViewController.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/26.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class RxObservableViewController: UIViewController {
    // MARK: property
    var disposeBag = DisposeBag()
    var observable: Observable<String>?
//    var observable: Observable<String> = Observable<String>.create { (observer) -> Disposable in
//        observer.onNext("我发送了事件")
//        observer.onCompleted()
//        return Disposables.create()
//    }
    // MARK: UI elements
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 120, width: 300, height: 60)
        button.center.x = view.center.x
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.setTitle("send", for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.8), for: .disabled)
        button.backgroundColor = .green
//        button.isEnabled = false
        return button
    }()
    lazy var subscribleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 200, width: 300, height: 60)
        button.center.x = view.center.x
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.setTitle("subscrible", for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.8), for: .disabled)
        button.backgroundColor = .green
//        button.isEnabled = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Observale"
        
        view.addSubview(sendButton)
        view.addSubview(subscribleButton)
        
//        sendButton.rx.tap.subscribe(onNext: { [weak self] in
        sendButton.rx.tap.subscribe(onNext: { _ in
            print("send actions")
            
//            RxObservableManager.shared.observable = Observable<String>.create { (observer) -> Disposable in
//                observer.onNext("我发送了事件")
//                observer.onCompleted()
//                return Disposables.create()
//            }
            
//            self?.observable = Observable<String>.create { (observer) -> Disposable in
//                observer.onNext("我发送了事件")
//                observer.onCompleted()
//                return Disposables.create()
//            }
//            
//            let _ = self?.observable?.subscribe(onNext: { (element) in
//                print("==\(element)==")
//            }, onError: { error in
//                print(error)
//            }, onCompleted: {
//                print("onCompleted")
//            }, onDisposed: {
//                print("onDisposed")
//            })
            
            RxCompletableManager.shared.cacheLocally().subscribe(onCompleted: {
                print("Completable completed")
            }, onError: { error in
                print(error)
            })
            .disposed(by: self.disposeBag)
            
        })
        RxObservableManager.shared.observable = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("我发送了事件")
            observer.onCompleted()
            return Disposables.create()
        }
        
//        let _ = self.observable?.subscribe(onNext: { (element) in
//            print("==\(element)==")
//        }, onError: { error in
//            print(error)
//        }, onCompleted: {
//            print("onCompleted")
//        }, onDisposed: {
//            print("onDisposed")
//        })

//        subscribleButton.rx.tap.subscribe { [weak self] in
//            self?.observable?.subscribe{ (element) in
//                print("==\(element)==")
//            }
//        }.disposed(by: disposeBag)

        createTest()
    }
    @objc func createTest() {
        
        Observable<String>.create { (observer) -> Disposable in
            observer.onNext("我发送了事件")
            observer.onCompleted()
            return Disposables.create()
        }.subscribe { (element) in
            print("==\(element)==")
        }.disposed(by: disposeBag)
        
//        Completable.create(subscribe: { (completable) -> Disposable in
////            completable(.completed)
//            completable(.error(MyError.error1((101, "Completable error"))))
//            return Disposables.create()
//        }).subscribe {
//            print("Completable completed")
//        } onError: { (error) in
//            print(error)
//        } onDisposed: {
//            print("Completable onDisposed")
//        }.disposed(by: disposeBag)
        
    }
}
