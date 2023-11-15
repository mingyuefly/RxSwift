//
//  HBSetCellModel.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/14.
//

import Foundation

class HBSetCellModel {
    var title:String?
    var subTitle: String?
    var imageName: String?
    var detailImageName: String?
    var detailHidden: Bool = false
    init(title: String? = nil, subTitle: String? = nil, imageName: String? = nil, detailImageName: String? = nil, detailHidden: Bool = false) {
        self.title = title
        self.subTitle = subTitle
        self.imageName = imageName
        self.detailImageName = detailImageName
        self.detailHidden = detailHidden
    }
}
