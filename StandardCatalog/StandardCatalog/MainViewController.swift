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
    
    var controller: UIViewController?
    
    switch indexPath.section {
    case 0: // UIKit
      switch indexPath.row {
      case 0:
        controller = SimpleTableViewController()
      case 1:
        controller = SimpleSearchTableViewController()
      case 2:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "ChatTableViewController")
      case 3:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "SimpleCollectionViewController")
      default:
        break
      }
    case 1: // App Services
      switch indexPath.row {
      case 0:
        controller = ContactsViewController()
      case 1:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "ContactsUIViewController")
      case 2:
        controller = RemindersViewController()
      case 3:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "EventKitUIViewController")
      case 4:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "MapsViewController")
      case 5:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "SpeechViewController")
      default:
        break
      }
    case 2: // Networking
      switch indexPath.row {
      case 0:
        controller = ListViewController()
      case 1:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController")
      default:
        break
      }
    case 3: // Caching
      switch indexPath.row {
      case 1:
        controller = NSCodingViewController()
      default:
        break
      }
    case 4: // Security
      switch indexPath.row {
      case 0:
        controller = self.storyboard?.instantiateViewController(withIdentifier: "KeychainServicesViewController")
      default:
        break
      }
    default:
      break
    }
    
    if let controller = controller {
      self.navigationController?.pushViewController(controller, animated: true)
    }
    
    
  }
  
}

extension MainViewController {
  
}
