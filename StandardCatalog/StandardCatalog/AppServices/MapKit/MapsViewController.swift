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
  
  func displayDirection(from coordinate1: CLLocationCoordinate2D, coordinate2: CLLocationCoordinate2D) {
    
    let request = MKDirections.Request()
    request.source = MKMapItem(placemark: MKPlacemark(coordinate: coordinate1, addressDictionary: nil))
    request.destination = MKMapItem(placemark: MKPlacemark(coordinate: coordinate2, addressDictionary: nil))
    request.requestsAlternateRoutes = true
    request.transportType = .automobile
    
    let directions = MKDirections(request: request)
    
    directions.calculate { [unowned self] response, error in
      guard let unwrappedResponse = response else { return }
      
      for route in unwrappedResponse.routes {
        self.mapView.add(route.polyline)
        self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
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

extension MapsViewController {
  
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
  
  func displaySampleDirections(locations: [Location]) {
    let coordinate1 = CLLocationCoordinate2D(latitude: locations[0].latitude,
                                             longitude: locations[0].longitude)
    
    let coordinate2 = CLLocationCoordinate2D(latitude: locations[1].latitude,
                                             longitude: locations[1].longitude)
    
    displayDirection(from: coordinate1, coordinate2: coordinate2)
  }
  
}

extension MapsViewController: MKMapViewDelegate {
  
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    return nil
  }
  
  func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
  }
  
  func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
    let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
    renderer.strokeColor = UIColor.blue
    return renderer
  }
  
}

extension MapsViewController: CLLocationManagerDelegate {
  
}
