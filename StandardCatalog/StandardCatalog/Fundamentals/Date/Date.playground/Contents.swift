//: Playground - noun: a place where people can play

import UIKit

let formatter = DateFormatter()
formatter.dateFormat =  "d MMM yyyy 'at' hh:mm:ss aaa z"
// "d MMMM yyyy 'at' HH:mm:ss a ZZZZ"
let stringDate = formatter.string(from: Date())

let dateAsString = "07:05:45 PM"
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "h:mm:ss a"
let date = dateFormatter.date(from: dateAsString)

dateFormatter.dateFormat = "HH:mm:ss"
let date24 = dateFormatter.string(from: date!)
print(date24)

