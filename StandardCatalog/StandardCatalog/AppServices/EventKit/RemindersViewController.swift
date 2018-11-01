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
  
  private let eventStore = EKEventStore()
  private var calendar: EKCalendar?
  private var isAccessGranted = false

  var reminders = [EKReminder]()
  
  deinit {
    removeObserver()
  }
  
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
  
  @objc func fetchReminders() {
    if isAccessGranted && calendar != nil {
      let predicate = eventStore.predicateForReminders(in: [calendar!])
      eventStore.fetchReminders(matching: predicate) { (reminders) in
        self.reminders = reminders ?? [EKReminder]()
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  func deleteReminder(item: String) {

    let predicate = NSPredicate(format: "title matches %@", item)
    let results = self.reminders.filter { predicate.evaluate(with: $0) }
    
    if results.count > 0 {
      for reminder in results {
        do {
          try eventStore.remove(reminder, commit: false)
        } catch {
          // Handle error in removing an item
        }
      }
      
      do {
        try eventStore.commit()
      } catch {
        // Handle error in commit
      }
    }
  }
  
  func toggleCompletedForReminder(reminder: EKReminder) {
    reminder.isCompleted = !reminder.isCompleted
    
    do {
      try eventStore.save(reminder, commit: true)
    } catch {
      // Handle error in updating reminder
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
    addObserver()
    fetchReminders()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return reminders.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    let reminder = reminders[indexPath.row]
    updateCell(cell, withReminder: reminder)
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(reminders[indexPath.row].title)
    
    let reminder = reminders[indexPath.row]
    let cell = tableView.cellForRow(at: indexPath)
    toggleCompletedForReminder(reminder: reminder)
    updateCell(cell!, withReminder: reminder)
    
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    if let item = reminders[indexPath.row].title {
      reminders.remove(at: indexPath.row)
      deleteReminder(item: item)
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
  }
  
  fileprivate func updateCell(_ cell: UITableViewCell, withReminder reminder: EKReminder) {
    cell.textLabel?.text = reminder.title
    cell.accessoryType = reminder.isCompleted ? .checkmark : .none
  }
}

// MARK: Observer
extension RemindersViewController {
  
  fileprivate func addObserver() {
    NotificationCenter.default
      .addObserver(self,
                   selector: #selector(RemindersViewController.fetchReminders),
                   name: Notification.Name.EKEventStoreChanged,
                   object: nil)
  }
  
  fileprivate func removeObserver() {
    NotificationCenter.default.removeObserver(self)
  }
  
}
