//
//  ViewController.swift
//  RxSwiftPractice
//
//  Created by Vincent Bacalso on 14/12/2017.
//  Copyright © 2017 Command Bin. All rights reserved.
//

import UIKit
import RxSwift

class MasterViewController: UIViewController {
  
  @IBOutlet weak var greetingsLabel: UILabel!
  
  let disposeBag = DisposeBag()
  
  @IBAction func selectCharacter(_ sender: Any) {
    
    let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
    detailVC.selectedCharacter
      .subscribe(onNext: { [weak self] character in
        self?.greetingsLabel.text = "Hello \(character)"
      }).disposed(by: disposeBag)
    
    navigationController?.pushViewController(detailVC, animated: true)
    
  }
  
}

