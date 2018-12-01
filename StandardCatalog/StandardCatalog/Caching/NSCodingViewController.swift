//
//  NSCodingViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 01/12/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import Foundation

/// This sample is base on https://www.raywenderlich.com/6733-nscoding-tutorial-for-ios-how-to-permanently-save-app-data

class Creature: NSObject {
  var title = ""
  var rating: Float = 0
  
  init(title: String, rating: Float) {
    super.init()
    self.title = title
    self.rating = rating
  }
}
