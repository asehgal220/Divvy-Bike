//
//  DetailViewController.swift
//  Dvvy Bikes
//
//  Created by Ananya Sehgal on 6/26/17.
//  Copyright © 2017 The Dawg. All rights reserved.




import UIKit
import CoreLocation
import MapKit

class DetailViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate
{
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var myTextView: UITextView!
    var coordinate = CLLocationCoordinate2DMake(0.0, 0.0)
    
    let locationManager = CLLocationManager()
    
    
    var detailItem:[String:String]!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        coordinate = CLLocationCoordinate2D(detailItem.latitudes, detailItem.longitudes)
        locationManager.delegate = self
        mapView.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        mapView.showsUserLocation = true
        mapView.userLocation.title = "My Location"
        
        setCenterOfMapToLocation(coordinate)
        addPinAnnotationToMapView(coordinate)
        
        
        
        
        func setCenterOfMapToLocation (place : CLLocationCoordinate2D) {
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
        }
        
        func addPinAnnotationToMapView(location: CLLocationCoordinate2D)
        {
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            mapView.addAnnotation(annotation)
        }

        
        
        
    }
}







