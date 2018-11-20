//
//  SpeechManager.swift
//  VoiceToText
//
//  Created by Vincent Bacalso on 15/04/2018.
//  Copyright © 2018 Vincent Bacalso. All rights reserved.
//


import Foundation
import UIKit
import AVFoundation
import Speech

public class SpeechManager: NSObject, AVAudioRecorderDelegate, AVAudioPlayerDelegate, SFSpeechRecognizerDelegate {
  
  static let sharedInstance = SpeechManager()
  
  public var recorder: AVAudioRecorder?
  
  fileprivate var speechTimer: Timer?
  
  fileprivate let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
  
  fileprivate var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
  
  fileprivate var recognitionTask: SFSpeechRecognitionTask?
  fileprivate let audioEngine = AVAudioEngine()
  
  private override init() {}
  
  func setupAudioRecording(withURL url: URL) {
    
    let settings = [AVSampleRateKey:NSNumber(value: 44100.0 as Float),
                    AVFormatIDKey:NSNumber(value: kAudioFormatLinearPCM as UInt32),
                    AVNumberOfChannelsKey:NSNumber(value: 2 as Int)]
    do {
      self.recorder = try AVAudioRecorder(url: url, settings: settings)
    } catch _ {
      print("Error Setting Audio Recording")
    }
    
    if let recorder = self.recorder {
      recorder.delegate = self
      recorder.isMeteringEnabled = true
      recorder.prepareToRecord()
      let audioSession = AVAudioSession.sharedInstance()
      do {
        try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try audioSession.setActive(true)
      } catch _ {
        
      }
    }
  }
  
  fileprivate func startRecordingAudioSession() {
    if let recorder = self.recorder {
      if !recorder.isRecording {
        let session = AVAudioSession.sharedInstance()
        do {
          try session.setActive(true)
        } catch _{
          
        }
        recorder.record()
      }
    }
  }
  
  fileprivate func stopRecordingAudioSession() {
    self.recorder?.stop()
  }
  
  public func isMicrophoneEnabled() -> Bool {
    let authStatus = AVAudioSession.sharedInstance().recordPermission()
    
    switch authStatus {
    case AVAudioSessionRecordPermission.granted:
      return true
    case AVAudioSessionRecordPermission.denied, AVAudioSessionRecordPermission.undetermined:
      return false
    }
    
  }
  
  public func setupAudioRecording(_ completion: @escaping(Bool) -> Void) {
    
    AVAudioSession.sharedInstance().requestRecordPermission { (authStatus) in
      
      if authStatus {
        completion(true)
      } else {
        completion(false)
      }
      
    }
    
  }
  
  public func setupSpeechRecognition(_ completion: @escaping (Bool) -> Void) {
    self.speechRecognizer?.delegate = self
    
    SFSpeechRecognizer.requestAuthorization { (authStatus) in
      
      var isEnabled = false
      
      switch authStatus {
      case .authorized:
        isEnabled = true
        break
      case .denied, .restricted, .notDetermined:
        isEnabled = false
        // showPermissionAlertToOpenSettings(withMessage: "TBMediaManager.Privacy.Speech".localized())
        print("User denied access to speech recognition")
        break
      }
      
      OperationQueue.main.addOperation() {
        // Notify calling function that the speec recognition is enabled
        completion(isEnabled)
      }
    }
    
  }
  
  public func startRecording(_ completion: @escaping (String?, Bool) -> Void) {
    
    self.startRecordingAudioSession()
    
    if recognitionTask != nil {
      recognitionTask?.cancel()
      recognitionTask = nil
    }
    
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(AVAudioSessionCategoryRecord)
      try audioSession.setMode(AVAudioSessionModeMeasurement)
      try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
    } catch {
      print("audioSession properties weren't set because of an error.")
    }
    
    recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
    
    let inputNode = audioEngine.inputNode
    
    guard let recognitionRequest = recognitionRequest else {
      fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
    }
    
    recognitionRequest.shouldReportPartialResults = true
    
    recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
      
      var isFinal = false
      
      completion(result?.bestTranscription.formattedString, isFinal)
      
      if let result = result {
        isFinal = result.isFinal
      }
      
      print("Did enter speech reocgnition with status isFinal: \(isFinal) and text: \(String(describing: result?.bestTranscription.formattedString))")
      
      if isFinal {
        self.audioEngine.stop()
        inputNode.removeTap(onBus: 0)
        
        self.recognitionRequest = nil
        self.recognitionTask = nil
        self.speechTimer = nil
        //self.speechRecognitionShouldEnd = false
        
        // only complete if isFinal
        completion(result?.bestTranscription.formattedString, isFinal)
      } else if error == nil {
        self.restartSpeechTimer()
      }
      
    })
    
    let recordingFormat = inputNode.outputFormat(forBus: 0)
    inputNode.removeTap(onBus: 0)
    inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
      self.recognitionRequest?.append(buffer)
      
    }
    
    audioEngine.prepare()
    
    do {
      try audioEngine.start()
    } catch {
      print("audioEngine couldn't start because of an error.")
    }
    
  }
  
  public func stopRecording() {
    if audioEngine.isRunning {
      audioEngine.stop()
      recognitionRequest?.endAudio()
    }
    self.stopRecordingAudioSession()
  }
  
  fileprivate func restartSpeechTimer() {
    speechTimer?.invalidate()
    print("Speech timer \(String(describing: speechTimer?.description)) has been created")
    speechTimer = Timer.scheduledTimer(withTimeInterval: 1.5, repeats: false, block: { (timer) in
      print("Speech timer \(timer.description) has ended")
      //self.speechRecognitionShouldEnd = true
      self.stopRecording()
    })
  }
  
  public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
    if available {
      // notify to enable button
    } else {
      // notify to disable button
    }
  }
  
}

