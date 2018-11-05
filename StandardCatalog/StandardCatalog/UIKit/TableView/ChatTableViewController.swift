//
//  ChatTableViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 04/11/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

/// A Starting point for creating a chat view
/// Original post from here: https://bit.ly/2QfW90E
class ChatTableViewController: UITableViewController {
  
  var items = Datastore.conversations
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    
    // TODO: Use a custom cell instead
    let text = items[indexPath.row]
    let messageType: MessageType = indexPath.row % 2 == 0 ? .incoming : .outgoing
    showMessage(type: messageType, text: text, in: cell)
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(items[indexPath.row])
  }
  
}

extension ChatTableViewController {
  
  func showMessage(type: MessageType, text: String, in view: UIView) {
    let label =  UILabel()
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 18)
    label.textColor = .white
    label.text = text
    
    let constraintRect = CGSize(width: 0.66 * view.frame.width,
                                height: .greatestFiniteMagnitude)
    let boundingBox = text.boundingRect(with: constraintRect,
                                        options: .usesLineFragmentOrigin,
                                        attributes: [.font: label.font],
                                        context: nil)
    label.frame.size = CGSize(width: ceil(boundingBox.width),
                              height: ceil(boundingBox.height))
    
    let bubbleSize = CGSize(width: label.frame.width + 28,
                            height: label.frame.height + 20)
    
    let bubbleView = SpeechBubbleView()
    bubbleView.messageType = type
    bubbleView.frame.size = bubbleSize
    bubbleView.backgroundColor = .clear
    bubbleView.center = view.center
    view.addSubview(bubbleView)
    
    label.center = bubbleView.center
    bubbleView.addSubview(label)
  }
  
}

extension ChatTableViewController {
  
  enum MessageType {
    case outgoing
    case incoming
  }
  
  class SpeechBubbleView: UIView {
    
    var messageType: MessageType = .outgoing
    
    var incomingColor = UIColor(white: 0.9, alpha: 1)
    var outgoingColor = UIColor(red: 0.09, green: 0.54, blue: 1, alpha: 1)
    
    override func draw(_ rect: CGRect) {
      let width = rect.width
      let height = rect.height
      
      let bezierPath = UIBezierPath()
      
      if messageType == .incoming {
        bezierPath.move(to: CGPoint(x: 22, y: height))
        bezierPath.addLine(to: CGPoint(x: width - 17, y: height))
        bezierPath.addCurve(to: CGPoint(x: width, y: height - 17), controlPoint1: CGPoint(x: width - 7.61, y: height), controlPoint2: CGPoint(x: width, y: height - 7.61))
        bezierPath.addLine(to: CGPoint(x: width, y: 17))
        bezierPath.addCurve(to: CGPoint(x: width - 17, y: 0), controlPoint1: CGPoint(x: width, y: 7.61), controlPoint2: CGPoint(x: width - 7.61, y: 0))
        bezierPath.addLine(to: CGPoint(x: 21, y: 0))
        bezierPath.addCurve(to: CGPoint(x: 4, y: 17), controlPoint1: CGPoint(x: 11.61, y: 0), controlPoint2: CGPoint(x: 4, y: 7.61))
        bezierPath.addLine(to: CGPoint(x: 4, y: height - 11))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height), controlPoint1: CGPoint(x: 4, y: height - 1), controlPoint2: CGPoint(x: 0, y: height))
        bezierPath.addLine(to: CGPoint(x: -0.05, y: height - 0.01))
        bezierPath.addCurve(to: CGPoint(x: 11.04, y: height - 4.04), controlPoint1: CGPoint(x: 4.07, y: height + 0.43), controlPoint2: CGPoint(x: 8.16, y: height - 1.06))
        bezierPath.addCurve(to: CGPoint(x: 22, y: height), controlPoint1: CGPoint(x: 16, y: height), controlPoint2: CGPoint(x: 19, y: height))
        
        incomingColor.setFill()
        
      } else {
        bezierPath.move(to: CGPoint(x: width - 22, y: height))
        bezierPath.addLine(to: CGPoint(x: 17, y: height))
        bezierPath.addCurve(to: CGPoint(x: 0, y: height - 17), controlPoint1: CGPoint(x: 7.61, y: height), controlPoint2: CGPoint(x: 0, y: height - 7.61))
        bezierPath.addLine(to: CGPoint(x: 0, y: 17))
        bezierPath.addCurve(to: CGPoint(x: 17, y: 0), controlPoint1: CGPoint(x: 0, y: 7.61), controlPoint2: CGPoint(x: 7.61, y: 0))
        bezierPath.addLine(to: CGPoint(x: width - 21, y: 0))
        bezierPath.addCurve(to: CGPoint(x: width - 4, y: 17), controlPoint1: CGPoint(x: width - 11.61, y: 0), controlPoint2: CGPoint(x: width - 4, y: 7.61))
        bezierPath.addLine(to: CGPoint(x: width - 4, y: height - 11))
        bezierPath.addCurve(to: CGPoint(x: width, y: height), controlPoint1: CGPoint(x: width - 4, y: height - 1), controlPoint2: CGPoint(x: width, y: height))
        bezierPath.addLine(to: CGPoint(x: width + 0.05, y: height - 0.01))
        bezierPath.addCurve(to: CGPoint(x: width - 11.04, y: height - 4.04), controlPoint1: CGPoint(x: width - 4.07, y: height + 0.43), controlPoint2: CGPoint(x: width - 8.16, y: height - 1.06))
        bezierPath.addCurve(to: CGPoint(x: width - 22, y: height), controlPoint1: CGPoint(x: width - 16, y: height), controlPoint2: CGPoint(x: width - 19, y: height))
        
        outgoingColor.setFill()
      }
      
      bezierPath.close()
      bezierPath.fill()
    }
    
  }
  
}
