//
//  MainViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 18/07/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

class MainViewController: UITableViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

extension MainViewController {
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let controller = SimpleTableViewController()
    self.navigationController?.pushViewController(controller, animated: true)
    
  }
  
}
