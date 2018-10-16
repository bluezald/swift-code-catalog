//
//  SimpleSearchTableViewController.swift
//  RxSwiftCatalog
//
//  Created by Vincent Bacalso on 16/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SimpleSearchTableViewController: UIViewController {
  
  var shownCities = [String]()
  let allCities = Datasource.items
  let disposeBag = DisposeBag()
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var searchBar: UISearchBar!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.dataSource = self
    
    searchBar.rx
      .text
      .orEmpty
      .debounce(0.5, scheduler: MainScheduler.instance)
      .distinctUntilChanged()
      .filter{ !$0.isEmpty }
      .subscribe(onNext: { [unowned self] query in
        self.shownCities = self.allCities.filter { $0.hasPrefix(query) }
        self.tableView.reloadData()
      })
      .disposed(by: disposeBag)
    
  }
  
}

extension SimpleSearchTableViewController: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return shownCities.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.textLabel?.text = self.shownCities[indexPath.row]
    
    return cell
  }
  
}
