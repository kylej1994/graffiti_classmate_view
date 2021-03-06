//
//  MapViewController.swift
//  Graffiti
//
//  Created by Henry Lewis on 3/3/17.
//  Copyright © 2017 Amanda Aizuss. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    let locationManager = LocationService.sharedInstance
    @IBOutlet weak var map: MKMapView!
    var initialDelta: Double!
    var annotations: [Annotation] = []
    var circle: MKCircle!

    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        
        map.showsUserLocation = true
        initialDelta = milesToDegrees(3)
        
        centerAroundUser()
        addCircle()
        addAnnoations()
        
        locationManager.addListener() { _ in
            self.updateCircle()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager.startUpdatingLocation()
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        locationManager.stopUpdatingLocation()
    }
    
    private func degreesToMiles(_ degrees: Double) -> Double {
        return degrees * 69.0
    }
    
    private func milesToDegrees(_ miles: Double) -> Double {
        return miles / 69.0
    }
    
    private func milesToMeter(_ miles: Double) -> Double {
        return miles * 1609.34
    }
    
    private func getCurrentLocation() -> CLLocationCoordinate2D? {
        guard
            let latitude = locationManager.getLatitude(),
            let longitude = locationManager.getLongitude()
            else {
                return nil
        }
        
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    private func centerAroundUser(animated: Bool = false) {
        guard let currentLoc = getCurrentLocation() else {
            return
        }
        
        let span = MKCoordinateSpan(latitudeDelta: initialDelta, longitudeDelta: initialDelta)
        let region = MKCoordinateRegion(center: currentLoc, span: span)
        let fittedRegion = map.regionThatFits(region)
        map.setRegion(fittedRegion, animated: animated)
    }
    

    
    func addAnnoations() {
        getCoordinates() { coordinates in
            let annotations = coordinates.map() { (coordinate) -> Annotation in
                return Annotation(coordinate: coordinate.coordinate)
            }
            
            self.annotations = self.annotations + annotations
            self.map.addAnnotations(annotations)
        }
    }
    
    func clearAnnotations() {
        map.removeAnnotations(self.annotations)
        self.annotations.removeAll()
    }

    private func getCoordinates(handler: @escaping ([CLLocation]) -> Void) {
        let currentLoc = map.centerCoordinate
        let span = map.region.span
        let radius = degreesToMiles(span.latitudeDelta)
        
        API.sharedInstance.getCoordinates(longitude: currentLoc.longitude, latitude: currentLoc.latitude, radius: radius) { response in
            switch response.result {
            case .success:
                if
                    let json = response.result.value as? [String:Any],
                    let coordinates = json["coordinates"] as? [CLLocation]
                {
                    handler(coordinates)
                }
            case .failure(let err):
                print("Error getting coordinates: \(err)")
            }
        }
    }
    
    private func addCircle() {
        guard let currentLoc = getCurrentLocation() else {
            return
        }
        
        circle = MKCircle(center: currentLoc, radius: milesToMeter(1))
        self.map.add(circle)
    }
    
    private func updateCircle() {
        map.remove(circle)
        addCircle()
    }
    
    //MARK: Action
    @IBAction func goToCurrentLocation(_ sender: Any) {
        centerAroundUser(animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    // Render Overlays
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let circleOverlay = overlay as? MKCircle {
            let circleRenderer = MKCircleRenderer(overlay: circleOverlay)
            circleRenderer.strokeColor = UIColor.black
            circleRenderer.alpha = 0.5
            circleRenderer.lineWidth = 1.0
            
            return circleRenderer
        }
        
        return MKOverlayRenderer()
    }
    
    // Map view changed
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        // TODO more efficient way of doing this
        clearAnnotations()
        addAnnoations()
    }
}
