//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class User {
  var name: String
  var subscriptions: [CarrierSubscription] = []
  
  private(set) var phones: [Phone] = []
  func add(phone: Phone) {
    phones.append(phone)
    phone.owner = self
  }
  
  init(name: String) {
    self.name = name
    print("User \(name) is initialized")
  }
  
  deinit {
    print("User \(name) is being deallocated")
  }
}

class Phone {
  let model: String
  weak var owner: User?
  var carrierSubscription: CarrierSubscription?
  
  func provision(carrierSubscription: CarrierSubscription) {
    self.carrierSubscription = carrierSubscription
  }
  
  func decommission() {
    self.carrierSubscription = nil
  }
  
  init(model: String) {
    self.model = model
    print("Phone \(model) is initialized")
  }
  
  deinit {
    print("Phone \(model) is being deallocated")
  }
}

class CarrierSubscription {
  let name: String
  let countryCode: String
  let number: String
  unowned let user: User
  lazy var completePhoneNumber: () -> String = {
    [unowned self] in
    self.countryCode + " " + self.number
  }
  
  init(name: String, countryCode: String, number: String, user: User) {
    self.name = name
    self.countryCode = countryCode
    self.number = number
    self.user = user
    user.subscriptions.append(self)
    
    print("CarrierSubscription \(name) is initialized")
  }
  
  deinit {
    print("CarrierSubscription \(name) is being deallocated")
  }
}

// Examples start here:

// 1
do {
  print("------------------------")
  print("Example 1: Basic")
  let user1 = User(name: "John")
}

// 2
do {
  print("------------------------")
  print("Example 2: Strong reference cycle")
  let user1 = User(name: "John")
  let iPhone = Phone(model: "iPhone 6s Plus")
  user1.add(phone: iPhone)
  
  /**
   Here, you add iPhone to user1. This automatically sets the owner property
   of iPhone to user1. A strong reference cycle between the two objects prevents
   ARC from deallocating them. As a result, both user1 and iPhone never deallocate.
   */
}

// 3
do {
  print("------------------------")
  print("Example 3: Unowned Modifier")
  let user1 = User(name: "John")
  let iPhone = Phone(model: "iPhone 6s Plus")
  user1.add(phone: iPhone)
  let subscription1 = CarrierSubscription(name: "TelBel", countryCode: "0032", number: "31415926", user: user1)
  iPhone.provision(carrierSubscription: subscription1)
}

// 3
do {
  print("------------------------")
  print("Example 4: Reference Cycle in Closure")
  let user1 = User(name: "John")
  let iPhone = Phone(model: "iPhone 6s Plus")
  user1.add(phone: iPhone)
  let subscription1 = CarrierSubscription(name: "TelBel", countryCode: "0032", number: "31415926", user: user1)
  iPhone.provision(carrierSubscription: subscription1)
  print(subscription1.completePhoneNumber())
}

// A class that generates WWDC Hello greetings.  See http://wwdcwall.com
class WWDCGreeting {
  let who: String
  
  init(who: String) {
    self.who = who
  }
  
  lazy var greetingMaker: () -> String = {
    [weak self] in
    return "Hello \(self?.who)."
  }
}

let greetingMaker: () -> String

do {
  let mermaid = WWDCGreeting(who: "caffinated mermaid")
  greetingMaker = mermaid.greetingMaker
}

greetingMaker()


