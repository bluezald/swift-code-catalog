//
//  Creature.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 07/12/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

/// This sample is base on https://www.raywenderlich.com/6733-nscoding-tutorial-for-ios-how-to-permanently-save-app-data

// Data
class Creature: NSObject, NSCoding {
  
  enum Keys: String {
    case title = "Title"
    case rating = "Rating"
  }
  
  var title = ""
  var rating: Float = 0
  
  init(title: String, rating: Float) {
    super.init()
    self.title = title
    self.rating = rating
  }
  
  func encode(with aCoder: NSCoder) {
    aCoder.encode(title, forKey: Keys.title.rawValue)
    aCoder.encode(rating, forKey: Keys.rating.rawValue)
  }
  
  required convenience init?(coder aDecoder: NSCoder) {
    let title = aDecoder.decodeObject(forKey: Keys.title.rawValue) as! String
    let rating = aDecoder.decodeFloat(forKey: Keys.rating.rawValue)
    self.init(title: title, rating: rating)
  }
  
}

class CreatureRecord: NSObject {
  
  enum Keys: String {
    case dataFile = "Data.plist"
    case thumbImageFile = "thumbImage.png"
    case fullImageFile = "fullImage.png"
  }
  
  private var _data: Creature?
  
  var data: Creature? {
    get {
      if _data != nil { return _data }
      
      let dataURL = docPath!.appendingPathComponent(Keys.dataFile.rawValue)
      guard let codedData = try? Data(contentsOf: dataURL) else { return nil }
      _data = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(codedData) as? Creature
      
      return _data
    }
    set {
      _data = newValue
    }
  }
  
  private var _thumbImage: UIImage?
  var thumbImage: UIImage? {
    get {
      if _thumbImage != nil { return _thumbImage }
      if docPath == nil { return nil }
      
      let thumbImageURL = docPath!.appendingPathComponent(Keys.thumbImageFile.rawValue)
      guard let imageData = try? Data(contentsOf: thumbImageURL) else { return nil }
      _thumbImage = UIImage(data: imageData)
      return _thumbImage
    }
    set {
      _thumbImage = newValue
    }
  }
  
  private var _fullImage: UIImage?
  var fullImage: UIImage? {
    get {
      if _fullImage != nil { return _fullImage }
      if docPath == nil { return nil }
      
      let fullImageURL = docPath!.appendingPathComponent(Keys.fullImageFile.rawValue)
      guard let imageData = try? Data(contentsOf: fullImageURL) else { return nil }
      _fullImage = UIImage(data: imageData)
      return _fullImage
    }
    set {
      _fullImage = newValue
    }
  }
  
  var docPath: URL?
  
  init(docPath: URL) {
    super.init()
    self.docPath = docPath
  }
  
  init(title: String, rating: Float, thumbImage: UIImage?, fullImage: UIImage?) {
    super.init()
    _data = Creature(title: title, rating: rating)
    self.thumbImage = thumbImage
    self.fullImage = fullImage
    saveData()
    saveImages()
  }
  
  func createDataPath() throws {
    guard docPath == nil else { return }
    
    docPath = CreatureDatabase.nextScaryCreatureDocPath()
    try FileManager.default.createDirectory(at: docPath!, withIntermediateDirectories: true, attributes: nil)
  }
  
  func saveData() {
    guard let data = data else { return }
    do {
      try createDataPath()
    }catch {
      print("Couldn't create save folder. " + error.localizedDescription)
      return
    }
    
    let dataURL = docPath!.appendingPathComponent(Keys.dataFile.rawValue)
    
    let codedData = try! NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: true)
    
    do {
      try codedData.write(to: dataURL)
    }catch {
      print("Couldn't write to save file: " + error.localizedDescription)
    }
  }
  
  func deleteDoc() {
    if let docPath = docPath {
      do {
        try FileManager.default.removeItem(at: docPath)
      }catch {
        print("Error Deleting Folder. " + error.localizedDescription)
      }
    }
  }
  
  func saveImages() {
    if _fullImage == nil || _thumbImage == nil { return }
    
    do {
      try createDataPath()
    }catch {
      print("Couldn't create save Folder. " + error.localizedDescription)
      return
    }
    
    let thumbImageURL = docPath!.appendingPathComponent(Keys.thumbImageFile.rawValue)
    let fullImageURL = docPath!.appendingPathComponent(Keys.fullImageFile.rawValue)
    
    let thumbImageData = UIImagePNGRepresentation(_thumbImage!)
    let fullImageData = UIImagePNGRepresentation(_fullImage!)
    
    try! thumbImageData!.write(to: thumbImageURL)
    try! fullImageData!.write(to: fullImageURL)
  }
}

class CreatureDatabase: NSObject {
  static let privateDocsDir: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentsDirectoryURL = paths.first!.appendingPathComponent("PrivateDocuments")
    do {
      try FileManager.default.createDirectory(at: documentsDirectoryURL,
                                              withIntermediateDirectories: true,
                                              attributes: nil)
    } catch {
      print("Couldn't create directory")
    }
    return documentsDirectoryURL
  }()
  
  class func nextScaryCreatureDocPath() -> URL? {
    guard let files = try? FileManager.default.contentsOfDirectory(at: privateDocsDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else { return nil }
    var maxNumber = 0
    
    files.forEach {
      if $0.pathExtension == "creature" {
        let fileName = $0.deletingPathExtension().lastPathComponent
        maxNumber = max(maxNumber, Int(fileName) ?? 0)
      }
    }
    
    return privateDocsDir.appendingPathComponent("\(maxNumber + 1).creature", isDirectory: true)
  }
  
  class func loadCreatureDocs() -> [CreatureRecord] {
    guard let files = try? FileManager.default.contentsOfDirectory(at: privateDocsDir, includingPropertiesForKeys: nil, options: .skipsHiddenFiles) else { return [] }
    
    return files
      .filter { $0.pathExtension == "creature" }
      .map { CreatureRecord(docPath: $0) }
  }
}
