//
//  ViewController.swift
//  Maps
//
//  Created by iD Student on 7/21/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        MapView.setUserTrackingMode(.Follow, animated: true)
    }

    @IBOutlet weak var MapView: MKMapView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dropPin(sender: UIBarButtonItem) {
        let pin = Pin(coordinate: MapView.userLocation.coordinate)
        MapView.addAnnotation(pin)
    }
    
   func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
    let Center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.latitude)
    let width = 10000.0
    let height = 10000.0
    let region = MKCoordinateRegionMakeWithDistance(Center, width, height)
    MapView.setRegion(region, animated: true)
    }


}

