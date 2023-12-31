//
//  ViewController.swift
//  RxSwiftHelloWorld
//
//  Created by gmy on 2023/11/6.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay
import RxGesture

class RxViewController: UIViewController {
    // MARK: root view life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        view.addSubview(userNameTextfield)
        view.addSubview(usernameValidLabel)
        view.addSubview(passwordTextfield)
        view.addSubview(passwordValidLabel)
        view.addSubview(nextButton)
        addRx()
    }
    // MARK: RxSwift
    func addRx() {
        let usernameValid = userNameTextfield.rx.text.orEmpty
            .map{
                $0.count >= self.minimalUsernameLength
            }
            .share(replay: 1)
        let passwordValid = passwordTextfield.rx.text.orEmpty
            .map{
                $0.count >= self.minimalPasswordLength
            }
            .share(replay: 1)
        let everythingValid = Observable.combineLatest(
            usernameValid,
            passwordValid
        ){$0 && $1}
            .share(replay: 1)
        usernameValid.bind(to: passwordTextfield.rx.isEnabled).disposed(by: disposeBag)
        usernameValid.bind(to: usernameValidLabel.rx.isHidden).disposed(by: disposeBag)
        passwordValid.bind(to: passwordValidLabel.rx.isHidden).disposed(by: disposeBag)
        everythingValid.bind(to: nextButton.rx.isEnabled).disposed(by: disposeBag)
        nextButton.rx.tap
            .subscribe(onNext:  { [weak self] in
                print("next")
                self?.showAlert()
            })
            .disposed(by: disposeBag)
        view.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext:  { _ in
                print("view tap")
                self.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }
    // MARK: actions
    func showAlert() {
        
        let tableVC = TableViewController()
        self.navigationController?.pushViewController(tableVC, animated: true)
        
//        let alertVC = UIAlertController(title: "RxExample", message: "This is wonderful", preferredStyle: .alert)
//        let confirmAction = UIAlertAction(title: "OK", style: .default) { _ in
//            let tableVC = TableViewController()
//            self.navigationController?.pushViewController(tableVC, animated: true)
//        }
//        alertVC.addAction(confirmAction)
//        self.navigationController?.present(alertVC, animated: true)
    }
    // MARK: UI elements
    lazy var userNameTextfield: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 100, width: 300, height: 30))
        textField.center.x = view.center.x
        textField.placeholder = "please enter user name"
        textField.font = UIFont(name: "", size: 15)
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        return textField
    }()
    lazy var passwordTextfield: UITextField = {
        let textField = UITextField(frame: CGRect(x: 0, y: 200, width: 300, height: 30))
        textField.center.x = view.center.x
        textField.placeholder = "please enter password"
        textField.font = UIFont(name: "", size: 15)
        textField.textAlignment = .left
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        return textField
    }()
    lazy var usernameValidLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 150, width: 300, height: 30))
        label.center.x = view.center.x
        label.font = UIFont(name: "", size: 15)
        label.text = "Username has to be at least charactors"
        label.textColor = .red
        return label
    }()
    lazy var passwordValidLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 250, width: 300, height: 30))
        label.center.x = view.center.x
        label.font = UIFont(name: "", size: 15)
        label.text = "Password has to be at least charactors"
        label.textColor = .red
        return label
    }()
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 300, width: 300, height: 60)
        button.center.x = view.center.x
        button.titleLabel?.font = UIFont.systemFont(ofSize: 35)
        button.setTitle("next", for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 1.0), for: .normal)
        button.setTitleColor(UIColor(white: 1.0, alpha: 0.8), for: .disabled)
        button.backgroundColor = .green
        button.isEnabled = false
        return button
    }()
    // MARK: property
    let minimalUsernameLength = 1
    let minimalPasswordLength = 1
    var disposeBag = DisposeBag()
}

