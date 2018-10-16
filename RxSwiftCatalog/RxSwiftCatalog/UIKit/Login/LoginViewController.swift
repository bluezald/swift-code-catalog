//
//  LoginViewController.swift
//  RxSwiftCatalog
//
//  Created by Vincent Bacalso on 16/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
  
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var loginEnabledLabel: UILabel!
  
  var loginViewModel = LoginViewModel()
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    _ = emailTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.emailText)
    _ = passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.passwordText)
    
    _ = loginViewModel.isValid.bind(to: loginButton.rx.isEnabled)
    
    loginViewModel.isValid.subscribe(onNext: { [unowned self] isValid in
      self.loginEnabledLabel.text = isValid ? "Enabled" : "Not Enabled"
      self.loginEnabledLabel.textColor = isValid ? .green : .red
    }).disposed(by: disposeBag)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}
