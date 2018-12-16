//
//  SettingsViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 10/12/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit



class SettingsViewController: UITableViewController {
  
  @IBOutlet weak var securityEmailSwitch: UISwitch!
  @IBOutlet weak var securityTextMessageSwitch: UISwitch!
  
  @IBOutlet weak var promotionsEmailSwitch: UISwitch!
  @IBOutlet weak var promotionsTextMessageSwitch: UISwitch!
  @IBOutlet weak var promotionsPhoneCallsSwitch: UISwitch!
  
  private let defaults = UserDefaults.standard
  
  
  enum Notifications {
    enum SecurityUpdates: String {
      case email = "Notifications.Security.Email"
      case textMessage = "Notifications.Security.TextMessage"
    }
    
    enum Promotions: String {
      case email = "Notifications.Promotions.Email"
      case textMessage = "Notifications.Promotions.TextMessage"
      case phoneCalls = "Notifications.Promotions.Phone"
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    loadFromDefaults()
    
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

extension SettingsViewController {
  
  func loadFromDefaults() {
    
    securityEmailSwitch.setOn(defaults.bool(forKey: Notifications.SecurityUpdates.email.rawValue), animated: false)
    
    securityTextMessageSwitch.setOn(defaults.bool(forKey: Notifications.SecurityUpdates.textMessage.rawValue), animated: false)
    
    promotionsEmailSwitch.setOn(defaults.bool(forKey: Notifications.Promotions.email.rawValue), animated: false)
    
    promotionsTextMessageSwitch.setOn(defaults.bool(forKey: Notifications.Promotions.textMessage.rawValue), animated: false)
    
    promotionsPhoneCallsSwitch.setOn(defaults.bool(forKey: Notifications.Promotions.phoneCalls.rawValue), animated: false)
    
  }
  
  
  
}
