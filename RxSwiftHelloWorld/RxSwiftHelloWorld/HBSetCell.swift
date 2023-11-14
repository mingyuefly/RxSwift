//
//  HBSetCell.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/13.
//

import UIKit
import SnapKit

class HBSetCell: UITableViewCell {
    // MARK: UI elements
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "title"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .left
        label.textColor = .black
        return label
    }()
    lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .right
        label.textColor = .gray
        return label
    }()
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    lazy var detailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    // MARK: properties
    var model: HBSetCellModel? {
        didSet {
            titleLabel.text = model?.title
            subTitleLabel.text = model?.subTitle
            guard let imageName = model?.imageName else {
                return
            }
            iconImageView.image = UIImage(named: imageName)
            guard let detailImageName = model?.detailImageName else {
                return
            }
            detailImageView.image = UIImage(named: detailImageName)
        }
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: setup UI
    func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subTitleLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(detailImageView)
        
        addConstraints()
    }
    func addConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(19)
            make.centerY.equalToSuperview()
            make.width.equalTo(17)
            make.height.equalTo(17)
        }
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(13)
            make.centerY.equalToSuperview()
        }
        detailImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-15)
            make.centerY.equalToSuperview()
            make.width.equalTo(15)
            make.height.equalTo(15)
        }
        subTitleLabel.snp.makeConstraints { make in
            make.trailing.equalTo(detailImageView.snp.leading).offset(-15)
            make.centerY.equalToSuperview()
        }
    }
}
