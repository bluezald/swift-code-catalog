//
//  SpeechViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 12/11/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit

///
/// When trying to use Speech framework, make sure to add description in
/// Info.plist for - NSSpeechRecognitionUsageDescription, NSMicrophoneUsageDescription
///
class SpeechViewController: UIViewController {
  
  let speechManager: SpeechManager = SpeechManager.sharedInstance
  
  @IBOutlet weak var recordingStatusLabel: UILabel!
  @IBOutlet weak var resultStringLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func record(_ sender: UIButton) {
    
    sender.isSelected = !sender.isSelected
    
    speechManager.setupSpeechRecognition { [unowned self] (isEnabled) in
      if isEnabled {
        
        if sender.isSelected {
          
          self.setViewRecording()
          self.speechManager.setupAudioRecording({ [unowned self] (isEnabled) in
            
            if isEnabled {
              
              // Show state that app is recording audio
              
              self.speechManager.startRecording({ [unowned self] (resultString, isFinal) in
                
                if let resultString = resultString {
                  
                  if isFinal {
                    self.resetView()
                    // Voice to text is successful
                  } else {
                    DispatchQueue.main.async {
                      // Update text in view
                      self.resultStringLabel.text = resultString
                    }
                  }
                }
              })
              
            } else {
              self.resetView()
            }
          })
        } else {
          self.resetView()
        }
      } else {
        // revert to default view since speech recognition was not enabled
        self.resetView()
      }
    }
    
  }
  
}

extension SpeechViewController {
  
  fileprivate func setViewRecording() {
    DispatchQueue.main.async {
      self.recordingStatusLabel.text = "Recording Status is on"
    }
  }
  
  fileprivate func resetView() {
    DispatchQueue.main.async {
      self.recordingStatusLabel.text = "Recording Status is off"
    }
    
    
  }
  
}

