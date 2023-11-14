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
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .white
        view.backgroundColor = UIColor.getWithHexString("#f6f7f8")
        title = "设置"
        view.addSubview(tableView)
        
        let sectionTuples1 = [("简约版", "未开启", "care_change_seticon", "me_narrow"), ("密码管理", "", "pwd_mgr_icon", "me_narrow"), ("支付设置", "", "pay_set_icon", "me_narrow"), ("消息与通知", "", "notice_push", "me_narrow")]
        var sectionModels1 = [HBSetCellModel]()
        sectionTuples1.forEach { tuple in
            sectionModels1.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let sectionTuples2 = [("权限与推荐", "", "system_set_qxtj", "me_narrow"), ("数字证书管理", "未安装", "certificate_set_icon", "me_narrow"), ("隐私", "", "yinsianniu", "me_narrow"), ("个人信息收集清单", "", "personalinfo", "me_narrow"), ("第三方个人共享清单", "", "tripartiteinfo", "me_narrow"), ("身份证", "待审核", "idCard_Normal", "me_narrow"), ("开发者模式", "", "certificate_set_icon", "me_narrow")]
        var sectionModels2 = [HBSetCellModel]()
        sectionTuples2.forEach { tuple in
            sectionModels2.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let sectionTuples3 = [("推荐给好友", "", "tuijian", "me_narrow"), ("关于和包", "9.15.63", "aboutHebao", "me_narrow")]
        var sectionModels3 = [HBSetCellModel]()
        sectionTuples3.forEach { tuple in
            sectionModels3.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let sectionTuples4 = [("在线客服", "", "me_online", "me_narrow"), ("账户与安全", "", "closinganaccount", "me_narrow")]
        var sectionModels4 = [HBSetCellModel]()
        sectionTuples4.forEach { tuple in
            sectionModels4.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let sectionTuples5 = [("切换账户", "", "accountSwitch2", "me_narrow"), ("安全退出", "", "safe_login_out_icon", "me_narrow")]
        var sectionModels5 = [HBSetCellModel]()
        sectionTuples5.forEach { tuple in
            sectionModels5.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        
        let dataSource = self.dataSource
        let items = Observable.just([
            SectionModel(model: "First section", items: sectionModels1),
            SectionModel(model: "Second section", items: sectionModels2),
            SectionModel(model: "Third section", items: sectionModels3),
            SectionModel(model: "fourth section", items: sectionModels4),
            SectionModel(model: "fifth section", items: sectionModels5)
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
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}

