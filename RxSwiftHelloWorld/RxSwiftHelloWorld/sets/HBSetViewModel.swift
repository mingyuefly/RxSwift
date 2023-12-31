//
//  HBSetViewModel.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/15.
//

import Foundation
import RxSwift
import RxDataSources

class HBSetViewModel {
    var sectionModels: [SectionModel<String, HBSetCellModel>] = [SectionModel<String, HBSetCellModel>]()
    var dataList: BehaviorSubject<Array<SectionModel<String, HBSetCellModel>>>?
    init() {
        let cellTuples1 = [("简约版", "未开启", "care_change_seticon", "me_narrow"), ("密码管理", "", "pwd_mgr_icon", "me_narrow"), ("支付设置", "", "pay_set_icon", "me_narrow"), ("消息与通知", "", "notice_push", "me_narrow")]
        var cellModels1 = [HBSetCellModel]()
        cellTuples1.forEach { tuple in
            cellModels1.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let cellTuples2 = [("权限与推荐", "", "system_set_qxtj", "me_narrow"), ("数字证书管理", "未安装", "certificate_set_icon", "me_narrow"), ("隐私", "", "yinsianniu", "me_narrow"), ("个人信息收集清单", "", "personalinfo", "me_narrow"), ("第三方个人共享清单", "", "tripartiteinfo", "me_narrow"), ("身份证", "待审核", "idCard_Normal", "me_narrow"), ("开发者模式", "", "certificate_set_icon", "me_narrow")]
        var cellModels2 = [HBSetCellModel]()
        cellTuples2.forEach { tuple in
            cellModels2.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let cellTuples3 = [("推荐给好友", "", "tuijian", "me_narrow"), ("关于和包", "9.15.63", "aboutHebao", "me_narrow")]
        var cellModels3 = [HBSetCellModel]()
        cellTuples3.forEach { tuple in
            cellModels3.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let cellTuples4 = [("在线客服", "", "me_online", "me_narrow"), ("账户与安全", "", "closinganaccount", "me_narrow")]
        var cellModels4 = [HBSetCellModel]()
        cellTuples4.forEach { tuple in
            cellModels4.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        let cellTuples5 = [("切换账户", "", "accountSwitch2", "me_narrow"), ("安全退出", "", "safe_login_out_icon", "me_narrow")]
        var cellModels5 = [HBSetCellModel]()
        cellTuples5.forEach { tuple in
            cellModels5.append(HBSetCellModel(title: tuple.0, subTitle: tuple.1, imageName: tuple.2, detailImageName: tuple.3))
        }
        sectionModels.append(SectionModel(model: "First section", items: cellModels1))
        sectionModels.append(SectionModel(model: "Second section", items: cellModels2))
        sectionModels.append(SectionModel(model: "Third section", items: cellModels3))
        sectionModels.append(SectionModel(model: "fourth section", items: cellModels4))
        sectionModels.append(SectionModel(model: "fifth section", items: cellModels5))
        dataList = BehaviorSubject(value: sectionModels)
    }
    func updateIDCardState(_ idCardStatus: String) {
        var subTitle = ""
        switch idCardStatus {
        case "1":
            subTitle = "待审核"
        case "2":
            subTitle = ""
        case "3":
            subTitle = "审核未通过"
        case "4":
            subTitle = "待上传"
        case "5":
            subTitle = "待完善"
        default:
            subTitle = ""
        }
        sectionModels[1].items[5].subTitle = subTitle
        dataList?.onNext(sectionModels)
    }
    func updateMainCertState() {
        sectionModels[1].items[1].subTitle = "已安装"
        dataList?.onNext(sectionModels)
    }
    deinit {
        print("HBSetViewModel deinit")
    }
}
