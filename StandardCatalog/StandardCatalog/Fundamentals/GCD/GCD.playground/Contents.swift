//: Playground - noun: a place where people can play

import UIKit

// Waiting for multiple requests to finish, then return to caller that
// all requests are done. -- we use a Dispatch Group

let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
let assets = [
  "https://1.img-dpreview.com/files/p/E~TS520x0~articles/8069731990/bb_ISO_100_f_1_8_1_8000s_DXO_0536-ACR.jpeg",
  "https://i.ytimg.com/vi/-obIxq6cbug/maxresdefault.jpg",
  "https://www.twinharbor.com/GalleryContent/Normal/Website-Photography-Sample-07_1.jpg"
]

let group = DispatchGroup()
var filesDownloaded = 0

for asset in assets {
  group.enter()
  
  let url = URL(string: asset)!
  
  let task = URLSession.shared.downloadTask(with: url) { localURL, urlResponse, error in
    if let localURL = localURL {
      do {
        let source = try String(contentsOf: localURL, encoding: .utf8)
        do {
          try source.write(to: documentsUrl.appendingPathComponent("image\(index)"),
                           atomically: true,
                           encoding: .utf8)
          filesDownloaded = filesDownloaded + 1
        } catch {
          print("\(error)")
        }
      } catch {
        print("\(error)")
      }
    }
    group.leave()
  }
  
  task.resume()
  
  
}

group.notify(queue: .main) {
  print("All requests are done")
  print("Files Downloaded: \(filesDownloaded)")
  print("Check in: \(documentsUrl)")
}
