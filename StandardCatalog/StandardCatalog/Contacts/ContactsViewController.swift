//
//  ContactsViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 21/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import Contacts

class ContactsViewController: UITableViewController {
  
  var items = [CNContact]()
  
  func accessContacts() {
    let store = CNContactStore()
    
    if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
      store.requestAccess(for: .contacts) { (authorized, error) in
        if authorized {
          
        }
      }
    }
    
  }
  
  func retrieveContactsWithStore(store: CNContactStore) {
    do {
//      let groups = try store.groups(matching: nil)
//      
//      let contacts = try store.unifiedContacts(matching: <#T##NSPredicate#>, keysToFetch: <#T##[CNKeyDescriptor]#>)
//      self.items = contacts
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    } catch {
      print(error)
    }
  }
  
}
