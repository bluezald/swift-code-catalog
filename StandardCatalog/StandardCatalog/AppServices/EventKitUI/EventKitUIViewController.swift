//
//  EventKitUIViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 30/11/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import EventKitUI

///
/// Make sure to add usage of the following classes:
///
/// EKEventViewController, for displaying existing events.
/// EKEventEditViewController, for creating, editing, or deleting events.
/// EKCalendarChooser, for selecting one or more calendars, and to determine whether a calendar
/// has read-only or read-write access.
///
class EventKitUIViewController: UIViewController {
  
  @IBOutlet weak var eventUILaunchButton: UIButton!
  
  @IBAction func launchEventView(_ sender: Any) {
    
    let eventController = EKEventViewController()
    eventController.delegate = self
    present(eventController, animated: true, completion: nil)
    
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
}

extension EventKitUIViewController: EKEventViewDelegate {
  
  func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
    
  }
  
}


