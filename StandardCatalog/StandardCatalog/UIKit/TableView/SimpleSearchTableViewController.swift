//
//  SimpleSearchTableViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 15/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

class SimpleSearchTableViewController: UITableViewController {
  
  var items = Datastore.items
  var filteredItems = [String]()
  let searchController = UISearchController(searchResultsController: nil)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.placeholder = "Search Items"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if isFiltering() {
      return filteredItems.count
    }
    
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    let item: String
    
    if isFiltering() {
      item = filteredItems[indexPath.row]
    } else {
      item = items[indexPath.row]
    }
    
    cell.textLabel?.text = item
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
  
}

extension SimpleSearchTableViewController {
  
  func searchBarIsEmpty() -> Bool {
    return searchController.searchBar.text?.isEmpty ?? true
  }
  
  func filterContentForSearchText(_ searchText: String, scope: String = "All") {
    filteredItems = items.filter({( item : String) -> Bool in
      return item.lowercased().contains(searchText.lowercased())
    })
    
    tableView.reloadData()
  }
  
  func isFiltering() -> Bool {
    return searchController.isActive && !searchBarIsEmpty()
  }

  
}

extension SimpleSearchTableViewController: UISearchResultsUpdating {
  
  func updateSearchResults(for searchController: UISearchController) {
    filterContentForSearchText(searchController.searchBar.text!)
  }
  
}

