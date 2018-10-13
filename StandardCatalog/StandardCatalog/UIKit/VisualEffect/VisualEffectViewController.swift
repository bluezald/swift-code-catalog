//
//  VisualEffectViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 23/07/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import Foundation

import UIKit

class VisualEffectViewController: UIViewController {
  
  @IBOutlet var addItemView: UIView!
  
  @IBOutlet weak var visualEffectView: UIVisualEffectView!
  
  var effect: UIVisualEffect!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    effect = visualEffectView.effect
    visualEffectView.effect = nil
    
    addItemView.layer.cornerRadius = 5
    
    
  }
  
  func animateIn() {
    self.view.addSubview(addItemView)
    addItemView.center = self.view.center
    
    addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
    addItemView.alpha = 0
    
    UIView.animate(withDuration: 0.4) {
      self.visualEffectView.effect = self.effect
      self.addItemView.alpha = 1
      self.addItemView.transform = CGAffineTransform.identity
    }
    
  }
  
  func animateOut () {
    UIView.animate(withDuration: 0.3, animations: {
      self.addItemView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
      self.addItemView.alpha = 0
      
      self.visualEffectView.effect = nil
      
    }) { (success:Bool) in
      self.addItemView.removeFromSuperview()
    }
  }
  
  @IBAction func addItem(_ sender: AnyObject) {
    animateIn()
  }
  @IBAction func dismissPopUp(_ sender: AnyObject) {
    animateOut()
  }
  
}
