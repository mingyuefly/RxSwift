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
        let tableView = UITableView(frame: view.bounds, style: .grouped)
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    // MARK: properties
    var disposeBag = DisposeBag()
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, String>>(
        configureCell: { (_, tv, indexPath, element) in
            let cell = tv.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = element
            return cell
        }
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "设置"
        view.addSubview(tableView)
        
        let dataSource = self.dataSource
        let items = Observable.just([
            SectionModel(model: "First section", items: [
                "简约版",
                "密码管理",
                "支付设置",
                "消息与通知"
            ]),
            SectionModel(model: "Second section", items: [
                "权限与推荐",
                "数字证书管理",
                "隐私",
                "个人信息收集清单",
                "第三方个人共享清单",
                "身份证",
                "开发者模式"
            ]),
            SectionModel(model: "Third section", items: [
                "在线客服",
                "账户与安全"
            ]),
            SectionModel(model: "fourth section", items: [
                "切换账户",
                "安全退出"
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
        return CGFLOAT_MIN;
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

