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
    
    addAnnotations()
    
  }
  
  func addAnnotations() {
    
    let annotation1 = MKPointAnnotation()
    annotation1.title = "SM Seaside"
    annotation1.coordinate = CLLocationCoordinate2D(latitude: 10.2818, longitude: 123.8812)
    
    let annotation2 = MKPointAnnotation()
    annotation2.title = "Ayala"
    annotation2.coordinate = CLLocationCoordinate2D(latitude: 10.3181, longitude: 123.9051)
    
    let annotation3 = MKPointAnnotation()
    annotation3.title = "SM City"
    annotation3.coordinate = CLLocationCoordinate2D(latitude: 10.3118, longitude: 123.9181)
    
    let annotation4 = MKPointAnnotation()
    annotation4.title = "Parkmall"
    annotation4.coordinate = CLLocationCoordinate2D(latitude: 10.3252, longitude: 123.9336)
    
    mapView.addAnnotation(annotation1)
    mapView.addAnnotation(annotation2)
    mapView.addAnnotation(annotation3)
    mapView.addAnnotation(annotation4)
    
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius,
                                                              regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
}
