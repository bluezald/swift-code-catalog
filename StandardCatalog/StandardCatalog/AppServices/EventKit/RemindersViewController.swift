//
//  RemindersViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 28/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import EventKit

///
/// When trying to access Calendar, make sure to add description in
/// Info.plist for -  NSRemindersUsageDescription / NSCalendarsUsageDescription
///
class RemindersViewController: UITableViewController {
  
  let eventStore = EKEventStore()
  var items = [String]()
  
  func accessCalendar() {
    let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
    
    switch (status) {
    case .notDetermined:
      print("Not determined")
    case .authorized:
      tableView.reloadData()
    case .restricted, .denied:
      print("Restricted or denied")
    }
  }
  
}

// MARK: Tableview
extension RemindersViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
}
