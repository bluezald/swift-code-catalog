//
//  SimpleCollectionViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 21/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

class SimpleCollectionViewController: UICollectionViewController {
  
  fileprivate let reuseIdentifier = "UICollectionViewCell"
  fileprivate let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

  var items = Datasource.items
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    return items.count
  }
  
  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                  for: indexPath)
    cell.backgroundColor = UIColor.black
    return cell
  }
  
}
