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
  private var calendar: EKCalendar?
  private var isAccessGranted = false

  var items = [String]()
  
  func accessReminders() {
    let status = EKEventStore.authorizationStatus(for: .reminder)
    
    switch (status) {
    case .notDetermined:
      print("Not determined")
      self.eventStore.requestAccess(to: .reminder) { [weak self] (granted, error) in
        self?.isAccessGranted = granted
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      }
    case .authorized:
      isAccessGranted = true
      tableView.reloadData()
    case .restricted, .denied:
      print("Restricted or denied")
    }
  }
  
  func setupCalendar() {
    let calendarTitle = "StandardCatalog"
    if calendar == nil {
      let calendars = eventStore.calendars(for: .reminder)
      let predicate = NSPredicate(format: "title matches %@", calendarTitle)
      let filtered = calendars.filter{ predicate.evaluate(with: $0) }
      
      if filtered.count > 0 {
        calendar = filtered.first
      } else {
        calendar = EKCalendar(for: .reminder, eventStore: eventStore)
        calendar?.title = calendarTitle
        calendar?.source = eventStore.defaultCalendarForNewReminders()?.source
        
        do {
          _ = try eventStore.saveCalendar(calendar!, commit: true)
        } catch {
          // handle error saving calendar
        }
      }
    }
  }
  
  func addReminder(item: String) {
    guard isAccessGranted, calendar != nil else {
      return
    }
    
    let reminder = EKReminder(eventStore: eventStore)
    reminder.title = item
    reminder.calendar = calendar!
    
    do {
      try eventStore.save(reminder, commit: true)
      print("Reminder Added")
    } catch {
      // Handle error
    }
  }
  
}

// MARK: Tableview
extension RemindersViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    accessReminders()
    setupCalendar()
    addReminder(item: "Do Dishes")
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
