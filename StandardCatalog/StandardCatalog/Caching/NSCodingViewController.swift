//
//  NSCodingViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 01/12/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import Foundation

/// This sample is base on https://www.raywenderlich.com/6733-nscoding-tutorial-for-ios-how-to-permanently-save-app-data

enum Keys: String {
  case title = "Title"
  case rating = "Rating"
}

class Creature: NSObject, NSCoding {
  var title = ""
  var rating: Float = 0
  
  init(title: String, rating: Float) {
    super.init()
    self.title = title
    self.rating = rating
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: Keys.title.rawValue)
    aCoder.encode(rating, forKey: Keys.rating.rawValue)
  }
  
  required init?(coder aDecoder: NSCoder) {
    let title = aDecoder.decodeObject(forKey: Keys.title.rawValue) as! String
    let rating = aDecoder.decodeFloat(forKey: Keys.rating.rawValue)
  }
  
  
}
