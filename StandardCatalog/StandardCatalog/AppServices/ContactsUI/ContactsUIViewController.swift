//
//  ContactsUIViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 22/11/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import ContactsUI

///
/// Make sure to add usage of the following classes:
///
/// CNContactPicker
/// CNContactPickerViewController
/// CNContactViewController
///
class ContactsUIViewController: UIViewController {
  
  @IBOutlet weak var contactsUILaunchButton: UIButton!
  
  @IBAction func launchContactsUI(_ sender: Any) {
    
    let contactPicker = CNContactPickerViewController()
    contactPicker.delegate = self
    contactPicker.displayedPropertyKeys = [CNContactGivenNameKey]
    present(contactPicker, animated: true, completion: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
   
  }
  
}

extension ContactsUIViewController: CNContactPickerDelegate {
  
  func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
    
    let contactViewController = CNContactViewController(for: contact)
    self.navigationController?.pushViewController(contactViewController, animated: true)
    
  }
  
  func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
    
  }
  
}

extension ContactsUIViewController: CNContactViewControllerDelegate {
  
  func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
    
  }
  
}
