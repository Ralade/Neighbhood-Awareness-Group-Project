//
//  MapViewController.swift
//  neighborhoodAwareness
//
//  Created by Luis Mendez on 10/31/18.
//  Copyright © 2018 Hein Soe. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var menuBtn: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var crimes: [Crime] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in map vc")
        //nyc location 40.73061, 73.935242
        menuBtn.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        //locationManager.requestWhenInUseAuthorization()
        let locationCenter = CLLocationCoordinate2DMake(40.73061, -73.935242)
        let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        let region = MKCoordinateRegion(center: locationCenter, span: span)
        mapView.setRegion(region, animated: false)
        
        
        /*if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }*/
        //getCrimeDelegate.getCrimes()
        self.mapView.showsUserLocation = true
        
    }
    
    /*func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: false)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            locationManager.startUpdatingLocation()
        }
    }*/

    /*func createAnnotationOnMap() {
        //removeAnnotation()
        if let restaurants = restaurants {
            for restaurant in restaurants {
                var image: UIImage?
                if restaurant.imageURL == nil {
                    image = UIImage(named: "Food")
                } else {
                    if let data = try? Data(contentsOf: restaurant.imageURL!) {
                        image = UIImage(data: data)
                    }
                }
                addAnnotationAtAddress(address: restaurant.address!, title: restaurant.name!, restImage: image!, rating: restaurant.ratingImage!)
            }
        }
        
    }*/

    func addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2D, crimeTitle: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = crimeTitle
        mapView.addAnnotation(annotation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let identifier = "customAnnotationView"
        
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        
        // var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        // custom image annotation
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        if (annotationView == nil) {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.rightCalloutAccessoryView = UIButton(type: .infoLight)
        }
        else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func getCrimeAfterSearch(searchedCrimes: [Crime]) {
        for crime in searchedCrimes {
            addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2DMake(crime.lat, crime.lon), crimeTitle: crime.crime)
        }
    }
}
