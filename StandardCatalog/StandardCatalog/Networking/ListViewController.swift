//
//  ListViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 17/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

// TODO: Use this as request

class ListViewController: UITableViewController {
  
  var items = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    cell.textLabel?.text = items[indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
  
}

extension ListViewController {
  
  internal func getList(completion: @escaping ([Any]?) -> Void) {
   
    let url = URL(string: "")
    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
      if let data = data {
        
        let json = try! JSONSerialization.jsonObject(with: data, options: [])
        
        if let itemsArray = json as? [Any] {
          
          var items = [Any]()
          
          for anItem in itemsArray {
            let newItem = "Add Item here"
            items.append(newItem)
          }
          completion(items)
          
        } else {
          completion(nil)
        }
        
      } else {
        completion(nil)
      }
      
    }
    
    task.resume()
    
  }
}

