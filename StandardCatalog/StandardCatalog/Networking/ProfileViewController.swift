//
//  ProfileViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 17/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
  
  @IBOutlet weak var avatarImageView: UIImageView!
  @IBOutlet weak var fullnameLabel: UILabel!
  
  public let userId: Int = 2
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.getUser { (user) in
      if let user = user {
        DispatchQueue.main.async {
          self.fullnameLabel.text = "\(user.firstName) \(user.lastName)"
        }
      }
    }
  }
  
  
}

extension ProfileViewController {
  
  internal func getUser(completion: @escaping (User?) -> Void) {
    
    let url = URL(string: "\(Reqres.domain)\(Reqres.user)\(userId)")
    
    let task = URLSession.shared.dataTask(with: url!) {(data, response, error) in
      
      guard let data = data else {
        completion(nil)
        return
      }
      
      guard let user = try? JSONDecoder().decode(User.self, from: data) else {
        completion(nil)
        return
      }
      
      completion(user)
    }
    
    task.resume()
    
  }
}
