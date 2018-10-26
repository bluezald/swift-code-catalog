//
//  ContactsViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 21/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import Contacts

///
/// When trying to access Contacts, make sure to add description in
/// Info.plist for - NSContactsUsageDescription
///
class ContactsViewController: UITableViewController {
  
  var items = [CNContact]()
  
  func accessContacts() {
    let store = CNContactStore()
    
    if CNContactStore.authorizationStatus(for: .contacts) == .notDetermined {
      store.requestAccess(for: .contacts) { (authorized, error) in
        if authorized {
          self.retrieveContactsWithStore(store: store)
        }
      }
    } else if CNContactStore.authorizationStatus(for: .contacts) == .authorized {
      self.retrieveContactsWithStore(store: store)
    }
    
  }
  
  func retrieveContactsWithStore(store: CNContactStore) {
    do {
      let groups = try store.groups(matching: nil)
      if let keysToFetch = [CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
                            CNContactEmailAddressesKey,
                            CNContactPhoneNumbersKey,
                            CNContactImageDataAvailableKey,
                            CNContactThumbnailImageDataKey] as? [CNKeyDescriptor] {
        for group in groups {
          let predicate = CNContact.predicateForContactsInGroup(withIdentifier: group.identifier)
          
          do {
            let contacts = try store.unifiedContacts(matching: predicate, keysToFetch: keysToFetch)
            self.items.append(contentsOf: contacts)
          } catch {
            print(error)
          }
        }
      }
      
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    } catch {
      print(error)
    }
  }
  
}

// MARK: Tableview
extension ContactsViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    accessContacts()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    cell.textLabel?.text = "\(items[indexPath.row].givenName) \(items[indexPath.row].familyName)"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
}
