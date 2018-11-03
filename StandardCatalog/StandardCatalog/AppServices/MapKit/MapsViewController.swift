//
//  MapsViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 30/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import MapKit

class MapsViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  let regionRadius: CLLocationDistance = 1000
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let initialLocation = CLLocation(latitude: 10.3157,
                                     longitude: 123.8854)
    centerMapOnLocation(location: initialLocation)
    
    
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius,
                                                              regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
}
