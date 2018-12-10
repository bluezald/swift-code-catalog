//
//  SettingsViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 10/12/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
}

extension SettingsViewController {
  
  override func tableView(_ tableView: UITableView,
                          didSelectRowAt indexPath: IndexPath) {
    
    if(indexPath.section == 0) { // Main Section
      
      if(indexPath.row == 1) {
        
      }
      
    } else if(indexPath.section == 1) {
      
      
    } else if(indexPath.section == 2) {
      
      
      
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
}
