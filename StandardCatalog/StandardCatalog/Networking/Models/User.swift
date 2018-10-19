//
//  User.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 19/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import Foundation

struct UsersPage: Codable {
  let page: Int
  let perPage: Int
  let total: Int
  let totalPages: Int
  let data: [User]
  
  private enum CodingKeys: String, CodingKey {
    case page = "page"
    case perPage = "per_page"
    case total = "total"
    case totalPages = "total_pages"
    case data = "data"
  }
}

struct User: Codable {
  let id: Int
  let firstName: String
  let lastName: String
  let avatar: String
  
  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case firstName = "first_name"
    case lastName = "last_name"
    case avatar = "avatar"
  }
}
