//
//  HBSetViewController.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/13.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxDataSources

class HBSetViewController: UIViewController {
    // MARK: UI elements
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .plain)
        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
        tableView.register(HBSetCell.self, forCellReuseIdentifier: "HBSetCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0;
        }
        return tableView
    }()
    // MARK: properties
    var disposeBag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, HBSetCellModel>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell: HBSetCell = tv.dequeueReusableCell(withIdentifier: "HBSetCell")! as! HBSetCell
            cell.model = element
            return cell
        }
    )
    let setViewModel = HBSetViewModel()
//    var items: Observable<Array<SectionModel<String, HBSetCellModel>>>?
    var idCardStatus: String?
    // MARK: root view life circles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.getWithHexString("#f6f7f8")
        title = "设置"
        view.addSubview(tableView)
        
        var dataList = BehaviorSubject(value: [SectionModel<String,Any>]())
        
        let dataSource = self.dataSource
        let items = Observable.just(setViewModel.sectionModels)
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
//        tableView.reloadItemsAtIndexPaths([IndexPath(row: 5, section: 1)], animationStyle: .automatic)
        
        let delayTime = DispatchTime.now() + DispatchTimeInterval.seconds(3)
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            self.querys()
        }
    }
    // MARK: update models
    func querys() {
        idCardStatus = "4"
        guard let idCardStatus = idCardStatus else {
            return
        }
        setViewModel.updateIDCardState(idCardStatus)
//        items = Observable.just(setViewModel.sectionModels)
    }
}

extension HBSetViewController: UITableViewDelegate {
    // to prevent swipe to delete behavior
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 46
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 1
        } else {
            return 10
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

