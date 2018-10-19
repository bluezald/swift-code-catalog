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
  
  var items = [User]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    
    getList { (users) in
      if let users = users {
        self.items = users
        DispatchQueue.main.async {
          self.tableView.reloadData()
        }
      }
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    let user = items[indexPath.row]
    cell.textLabel?.text = "\(user.firstName) \(user.lastName)"
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
  
}

extension ListViewController {
  
  internal func getList(completion: @escaping ([User]?) -> Void) {
   
    let url = URL(string: "\(Reqres.domain)\(Reqres.users)")
    
    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
      
      guard let data = data else {
        completion(nil)
        return
      }
      
      guard let usersPage = try? JSONDecoder().decode(UsersPage.self, from: data) else {
        completion(nil)
        return
      }
      
      completion(usersPage.data)
    }
    
    task.resume()
    
  }
}

