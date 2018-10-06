//: Playground - noun: a place where people can play

import Foundation

// This demo is from: http://kiloloco.com/courses/196880/lectures/6035136

let jsonData = """
[
    {
        "id": 1,
        "name": "Kyle",
        "petAge": 3,
        "petId": 1,
        "petName": "Snowball"
    },
    {
        "id": 2,
        "name": "Sarah",
        "petAge": 8,
        "petId": 2,
        "petName": "Max"
    },
    {
        "id": 3,
        "name": "Bob",
        "petAge": 2,
        "petId": 3,
        "petName": "Morty"
    }
]
""".data(using: .utf8)!

struct User: Codable {
  let id: Int
  let name: String
  
  // Instead of flatting the properties, the properties were moved
  // to a pet object, with a nested coding keys
  //    let petId: Int
  //    let petName: String
  //    let petAge: Int
  
  let pet: Pet
  
  struct Pet: Codable {
    let id: Int
    let name: String
    let age: Int
    
    private enum CodingKeys: String, CodingKey {
      case id = "petId"
      case name = "petName"
      case age = "petAge"
    }
  }
  
  private enum CodingKeys: String, CodingKey {
    case id, name, pet
  }
  
  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.id = try container.decode(Int.self, forKey: .id)
    self.name = try container.decode(String.self, forKey: .name)
    self.pet = try Pet(from: decoder)
  }
  
}

let users = try! JSONDecoder().decode([User].self, from: jsonData)
print(users)
