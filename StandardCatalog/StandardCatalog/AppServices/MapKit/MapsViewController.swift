//
//  MapsViewController.swift
//  StandardCatalog
//
//  Created by Vincent Bacalso on 30/10/2018.
//  Copyright © 2018 CommandBin. All rights reserved.
//

import UIKit
import MapKit

///
/// When trying to access current location, make sure to add description in
/// Info.plist for - NSLocationAlwaysAndWhenInUseUsageDescription,
/// NSLocationWhenInUseUsageDescription
///
class MapsViewController: UIViewController {
  
  @IBOutlet weak var mapView: MKMapView!
  let regionRadius: CLLocationDistance = 10000
  var locationManager: CLLocationManager?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    mapView.delegate = self
    
    setLocationManager()
    
    let initialLocation = CLLocation(latitude: 10.3181,
                                     longitude: 123.90)
    centerMapOnLocation(location: initialLocation)
    
    addAnnotations()
    
  }
  
  func setLocationManager() {
    let locationManager = CLLocationManager()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    
    // Check for Location Services
    if (CLLocationManager.locationServicesEnabled()) {
      locationManager.requestAlwaysAuthorization()
      locationManager.requestWhenInUseAuthorization()
    }
    
    //Zoom to user location
    if let userLocation = locationManager.location?.coordinate {
      let viewRegion = MKCoordinateRegionMakeWithDistance(userLocation, 200, 200)
      mapView.setRegion(viewRegion, animated: false)
    }
    
    self.locationManager = locationManager
    
    DispatchQueue.main.async {
      self.locationManager?.startUpdatingLocation()
    }
  }
  
  func addAnnotations() {
    
    if let locations = Location.getSampleLocations() {
      
      for location in locations {
        
        let annotation = MKPointAnnotation()
        annotation.title = location.title
        annotation.coordinate = CLLocationCoordinate2D(latitude: location.latitude,
                                                       longitude: location.longitude)
        mapView.addAnnotation(annotation)
      }
      
    }
    
  }
  
  func centerMapOnLocation(location: CLLocation) {
    let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                              regionRadius,
                                                              regionRadius)
    mapView.setRegion(coordinateRegion, animated: true)
  }
  
}

extension MapsViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    return nil
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
  }
  
}

extension MapsViewController: CLLocationManagerDelegate {
  
}
