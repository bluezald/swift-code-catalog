//
//  LoginViewModel.swift
//  RxSwiftPractice
//
//  Created by Vincent Bacalso on 14/12/2017.
//  Copyright © 2017 Command Bin. All rights reserved.
//

import Foundation
import RxSwift

struct LoginViewModel {
  
  var emailText = Variable<String>("")
  var passwordText = Variable<String>("")
  
  var isValid: Observable<Bool> {
    return Observable.combineLatest(emailText.asObservable(),
                                    passwordText.asObservable(),
                                    resultSelector: { (email, password) in
      email.count >= 3 && password.count >= 3
    })
  }
  
}
