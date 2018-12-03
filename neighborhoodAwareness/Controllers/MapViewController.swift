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
    var crimeLat: Double?
    var crimeLong: Double?
    var boundaries:[CLLocationCoordinate2D] = []
    var borough: [Borough] = []
    let boroughName = ["Manhattan", "Queens", "Bronx", "Brooklyn", "Staten+Island"]
    
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
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: locationCenter, span: span)
        mapView.setRegion(region, animated: false)
        
        
        /*if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }*/
        //getCrimeDelegate.getCrimes()
        self.mapView.showsUserLocation = true
        
        getBoundaries()
        
    }
    
    func getBoundaries() {
        
        for (index, eachBorough) in boroughName.enumerated() {
            var zeorOrOne = 0
            if index > 2 {
                zeorOrOne = 1
            }
            CrimeAPIManager().getBoundaries(boroughName: eachBorough, whichIndex: zeorOrOne) { (eachBoro, error) in
                DispatchQueue.main.async {
                    self.borough.append(eachBoro!)
                    print(self.borough.count)
                    self.addBoundaries()
                }
            }
        }
        /*CrimeAPIManager().getAllBoroughBoundaries { (boroughArray, error) in
            if error == nil {
                self.borough = boroughArray!
                print(self.borough.count)
                DispatchQueue.main.async {
                    self.borough = boroughArray!
                    print(self.borough.count)
                    self.addBoundaries()
                }
            } else {
                print("error with \(error?.localizedDescription)")
            }
        }*/
        /*CrimeAPIManager().test { (boundaryArray, error) in
            if error == nil {
                for eachBoundary in boundaryArray! {
                    let eachBound = eachBoundary as! NSArray
                    let long = eachBound[0] as! Double
                    let lat = eachBound[1] as! Double
                    self.boundaries.append(CLLocationCoordinate2DMake(lat, long))
                }
                DispatchQueue.main.async {
                    self.addBoundaries()
                }
            } else {
                print("error with \(error?.localizedDescription)")
            }
        }*/
    }
    
    func addBoundaries() {
        for each in borough {
            let poly = Polygon(coordinates: each.boundaries, count: each.boundaries.count)
            poly.name = each.boroughName
            mapView.addOverlay(poly)
            //mapView.addOverlay(MKPolygon(coordinates: each.boundaries, count: each.boundaries.count))
        }
        
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        //custom polygon
        if let overlay = overlay as? Polygon {
            let polyView = MKPolygonRenderer(overlay: overlay)
            let name = overlay.name!
            switch name {
                case "Manhattan":
                    polyView.strokeColor = UIColor.green
                    polyView.fillColor = UIColor.green
                case "Queens":
                    polyView.strokeColor = UIColor.orange
                    polyView.fillColor = UIColor.orange
                case "Bronx":
                    polyView.strokeColor = UIColor.red
                    polyView.fillColor = UIColor.red
                case "Brooklyn":
                    polyView.strokeColor = UIColor.yellow
                    polyView.fillColor = UIColor.yellow
                case "Staten+Island":
                    polyView.strokeColor = UIColor.purple
                    polyView.fillColor = UIColor.purple
                default:
                    polyView.strokeColor = UIColor.gray
            }
            
            return polyView
        }
        // default polygon
        /*if overlay is MKPolygon {
            let polygonView = MKPolygonRenderer(overlay: overlay)
            polygonView.strokeColor = UIColor.red
            return polygonView
        }*/
        
        return MKPolygonRenderer()
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
    
    func getGeoLocation(coordinate: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let placeMarks = placemarks {
                
                let place = placeMarks.first
                
                print(place?.location)
                print(place?.thoroughfare)
                print(place?.subThoroughfare)
                print(place?.isoCountryCode)
                print(place?.subLocality)
                print(place?.subAdministrativeArea)
                
            }
        }
    }

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
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        //selectedCrime =
        performSegue(withIdentifier: "detailCrime", sender: self)
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        crimeLat = view.annotation?.coordinate.latitude
        crimeLong = view.annotation?.coordinate.longitude
    }
    
    func getCrimeAfterSearch(searchedCrimes: [Crime]) {
        self.crimes = searchedCrimes
        for crime in searchedCrimes {
            addAnnotationAtCoordinate(coordinate: CLLocationCoordinate2DMake(crime.lat, crime.lon), crimeTitle: crime.crime)
            //getGeoLocation(coordinate: CLLocationCoordinate2DMake(crime.lat, crime.lon))
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailCrime" {
            let destinationVC = segue.destination as! DetailsCrimeViewController
            for crime in crimes {
                if crime.lat == crimeLat && crimeLong == crime.lon {
                    destinationVC.crimeDetails = crime
                }
            }
        }
    }
}
