//
//  DetailViewController.swift
//  RxSwiftPractice
//
//  Created by Vincent Bacalso on 14/12/2017.
//  Copyright © 2017 Command Bin. All rights reserved.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
  
  private let selectedCharacterVariable = Variable("User")
  
  var selectedCharacter: Observable<String> {
    return selectedCharacterVariable.asObservable()
  }
  
  @IBAction func characterSelected(_ sender: UIButton) {
    guard let characterName = sender.titleLabel?.text else {return}
    selectedCharacterVariable.value = characterName
  }
  
}

