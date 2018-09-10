//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class User {
  var name: String
  
  init(name: String) {
    self.name = name
    print("User \(name) is initialized")
  }
  
  deinit {
    print("User \(name) is being deallocated")
  }
}

let user1 = User(name: "John")
