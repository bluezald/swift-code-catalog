//
//  SimpleTableViewController.swift
//  RxSwiftCatalog
//
//  Created by Vincent Bacalso on 31/07/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SimpleTableViewController: UIViewController {
  
  let persons = [
    RCPerson(name: "Esmeralda Pape", age:25),
    RCPerson(name: "Takako Spillers", age:24),
    RCPerson(name: "Allena Poss", age:20),
    RCPerson(name: "Lyndon Addison", age:32),
    RCPerson(name: "Rolande Purves", age:35),
    RCPerson(name: "Dorethea Roman", age:18),
    RCPerson(name: "Akiko Peil", age:40),
    RCPerson(name: "Celestina Westphal", age:52),
    RCPerson(name: "Shameka Doverspike", age:37),
    RCPerson(name: "Terence Manthey", age:59)
  ]
  
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let objects: Observable<[RCPerson]> = Observable.just(persons)
    
    // Displaying a table view with a simple array
    _ = objects.bind(to: tableView.rx.items(cellIdentifier: "UITableViewCell")) {
      _, person, cell in
      cell.textLabel?.text = person.name
      cell.detailTextLabel?.text = String(person.age)
    }.disposed(by: disposeBag)
    
    // Selecting a cell in a table view
    tableView.rx.modelSelected(RCPerson.self).subscribe(onNext: {
      person in
      print("Cell selected has a person name: \(person.name)")
    }).disposed(by: disposeBag)
    
    
  }
  
}

