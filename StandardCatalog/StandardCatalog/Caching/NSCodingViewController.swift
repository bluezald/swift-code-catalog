//
//  NSCodingViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 01/12/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

extension UIImage {
  func resized(newSize: CGSize) -> UIImage {
    let horizontalRatio = newSize.width / size.width
    let verticalRatio = newSize.height / size.height
    
    let ratio = max(horizontalRatio, verticalRatio)
    
    return resized(ratio: ratio)
  }
  
  func resized(ratio: CGFloat) -> UIImage {
    let newSize = CGSize(width: size.width * ratio, height: size.height * ratio)
    UIGraphicsBeginImageContextWithOptions(newSize, true, 0)
    draw(in: CGRect(origin: .zero, size: newSize))
    let newImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return newImage!
  }
}

class NSCodingViewController: UITableViewController {
  
  var creatures: [CreatureRecord] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    navigationItem.leftBarButtonItem = editButtonItem
    
    let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped(_:)))
    navigationItem.rightBarButtonItem = addButton
    
    title = "Creatures"
    
    loadCreatures()
  }
  
  // MARK: - Segues
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showDetail" {
      if let indexPath = tableView.indexPathForSelectedRow {
        let object = creatures[indexPath.row]
        let controller = segue.destination as! DetailViewController
        controller.detailItem = object
      }
    }
  }
  
  override func didMove(toParentViewController parent: UIViewController?) {
    tableView.reloadData()
  }
  
  func loadCreatures() {
    creatures = CreatureDatabase.loadCreatureDocs()
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return creatures.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    let creature = creatures[indexPath.row]
    cell.textLabel!.text = creature.data?.title
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
      let creatureToDelete = creatures.remove(at: indexPath.row)
      creatureToDelete.deleteDoc()
      tableView.deleteRows(at: [indexPath], with: .fade)
    }
  }
  
  // MARK: - IBActions
  
  @objc func addTapped(_ sender: Any) {
//    let newDoc = ScaryCreatureDoc(title: "New Creature", rating: 0, thumbImage: nil, fullImage: nil)
//    creatures.append(newDoc)
//
//    let newIndexPath = IndexPath(row: creatures.count - 1, section: 0)
//    tableView.insertRows(at: [newIndexPath], with: .automatic)
//    tableView.selectRow(at: newIndexPath, animated: true, scrollPosition: .middle)
//    performSegue(withIdentifier: "showDetail", sender: self)
//  }
}

}

class DetailViewController: UIViewController {
  @IBOutlet weak var detailDescriptionLabel: UILabel!
  @IBOutlet weak var titleField: UITextField!
  @IBOutlet weak var imageView: UIImageView!
  
  private var picker: UIImagePickerController!
  
  var detailItem: CreatureRecord? {
    didSet {
      if isViewLoaded {
        configureView()
      }
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    picker = UIImagePickerController()
    configurePicker()
    configureView()
  }
  
  func configurePicker() {
    picker.delegate = self
    picker.sourceType = .photoLibrary
    picker.allowsEditing = false
  }
  
  func configureView() {
    
    if let detailItem = detailItem {
      titleField.text = detailItem.data!.title
      imageView.image = detailItem.fullImage
      detailDescriptionLabel.isHidden = imageView.image != nil
    }
  }
  
  @IBAction func addPictureTapped(_ sender: UIButton) {
    present(picker, animated: true, completion: nil)
  }
  
  @IBAction func titleFieldTextChanged(_ sender: UITextField) {
    detailItem?.data?.title = sender.text!
    detailItem?.saveData()
  }
  
}

extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
    dismiss(animated: true, completion: nil)
  }
  
  private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
    let fullImage = info[UIImagePickerControllerOriginalImage as NSString] as! UIImage
    let concurrentQueue = DispatchQueue(label: "ResizingQueue", attributes: .concurrent)
    
    concurrentQueue.async {
      let thumbImage = fullImage.resized(newSize: CGSize(width: 107, height: 107))
      
      DispatchQueue.main.async {
        self.detailItem?.fullImage = fullImage
        self.detailItem?.thumbImage = thumbImage
        self.imageView.image = fullImage
        self.detailItem?.saveImages()
      }
    }
    dismiss(animated: true, completion: nil)
  }
}

extension DetailViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
