//
//  Reqres.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 18/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import Foundation

// This is the endpoints data from reqres free service https://reqres.in/
struct Reqres {
  
  static let domain = "https://reqres.in"
  
  static let users = 	"/api/users?page=2"
  static let user = "/api/users/"
  
  // Create, Update, Patch, Delete
  
  static let register = "/api/register"
  static let login = "/api/login"
  
}
