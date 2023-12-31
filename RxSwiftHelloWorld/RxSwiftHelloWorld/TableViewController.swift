//
//  TableViewController.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/10.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class TableViewController: UIViewController {
    // MARK: root view life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Rx TableView"
        view.addSubview(tableView)
        var array1 = ["setVC", "Observable"]
        var array2 = (2..<20).map {"\($0)"}
        array1.append(contentsOf: array2)
        let items = Observable.just(    
            array1
        )
        items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) {row , element, cell in
            cell.textLabel?.text = "\(element) @ row \(row)"
            cell.accessoryType = .detailButton
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(String.self).subscribe { value in
            self.cellSelectAction(value)
        }.disposed(by: disposeBag)
        tableView.rx.itemAccessoryButtonTapped.subscribe(onNext: { indexPath in
//            DefaultWireframe.presentAlert("Tapped Detail @ \(indexPath.section),\(indexPath.row)")
            let alertVC = UIAlertController(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
                let tableVC = RxTableViewControllerExample()
                self.navigationController?.pushViewController(tableVC, animated: true) 
            }
            alertVC.addAction(confirmAction)
            self.navigationController?.present(alertVC, animated: true)
        })
        .disposed(by: disposeBag)
        
    }
    // MARK: actions
    func cellSelectAction(_ rowStr: String) {
        if rowStr.hasPrefix("setVC") {
            let tableVC = HBSetViewController()
            self.navigationController?.pushViewController(tableVC, animated: true)
        } else if rowStr.hasPrefix("Observable") {
            let observableVC = RxObservableViewController()
            self.navigationController?.pushViewController(observableVC, animated: true)
        } else {
            DefaultWireframe.presentAlert("Tapped `\(rowStr)`")
        }
    }
    // MARK: UI elements
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    // MARK: properties
    var disposeBag = DisposeBag()
}

