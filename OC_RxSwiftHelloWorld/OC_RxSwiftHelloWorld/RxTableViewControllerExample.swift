//
//  RxTableViewControllerExample.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources
//import Differentiator

class RxTableViewControllerExample: UIViewController, UITableViewDelegate {
    // MARK: UI elements
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    // MARK: properties
    var disposeBag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(element) @ row \(indexPath.row)"
            return cell
        },
        titleForHeaderInSection: { dataSource, sectionIndex in
            return dataSource[sectionIndex].model
        }
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Rx TableView Example"
        view.addSubview(tableView)
        
        let dataSource = self.dataSource
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                1.0,
                2.0,
                3.0
            ]),
            SectionModel(model: "Second section", items: [
                1.0,
                2.0,
                3.0
            ]),
            SectionModel(model: "Third section", items: [
                1.0,
                2.0,
                3.0
            ])
        ])
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        tableView.rx
            .itemSelected
            .map { indexPath in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { pair in
                DefaultWireframe.presentAlert("Tapped `\(pair.1)` @ \(pair.0)")
            })
            .disposed(by: disposeBag)
        tableView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
    }
    // to prevent swipe to delete behavior
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        40
//    }
}
