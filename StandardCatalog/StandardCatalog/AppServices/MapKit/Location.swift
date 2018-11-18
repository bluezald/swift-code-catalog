//
//  Location.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 18/11/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import Foundation

struct Location: Codable {
  let title: String
  let latitude: Double
  let longitude: Double
  
  enum CodingKeys: String, CodingKey {
    case title
    case latitude
    case longitude
  }
  
  static func getSampleLocations() -> [Location]? {
    
    if let url = Bundle.main.url(forResource: "Locations", withExtension: "json") {
      do {
        let data = try Data(contentsOf: url)
        print(data)
        let locations = try JSONDecoder().decode([Location].self, from: data)
        return locations
      } catch {
        
      }
    }
    return nil
  }
  
}
