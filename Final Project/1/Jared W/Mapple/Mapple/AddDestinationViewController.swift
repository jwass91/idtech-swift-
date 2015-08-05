//
//  ViewController.swift
//  Mapple
//
//  Created by iD Student on 7/7/15.
//  Copyright (c) 2015 iD Student. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class AddDestinationViewController: UIViewController, CLLocationManagerDelegate, UITextFieldDelegate {
    
    private var locationManager = CLLocationManager()
    
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        destinationField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        self.mapView.showsUserLocation = true
    }
    
    func textFieldShouldReturn(destinationField: UITextField) -> Bool {
        destinationField.resignFirstResponder()
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var destination = NSEntityDescription.insertNewObjectForEntityForName("Destination", inManagedObjectContext: context) as! Destination
        destination.name = self.destinationField.text
        destination.lat = self.mapView.region.center.latitude
        destination.lon = self.mapView.region.center.longitude
        destination.latDelta = self.mapView.region.span.latitudeDelta
        destination.lonDelta = self.mapView.region.span.longitudeDelta
        
        context.save(nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        return true;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        let region = MKCoordinateRegionMakeWithDistance(self.locationManager.location.coordinate, 15000, 15000)
        self.mapView.setRegion(region, animated: true)
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
//        self.dismissViewControllerAnimated(true, completion: nil)
    self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveAction(sender: AnyObject) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var destination = NSEntityDescription.insertNewObjectForEntityForName("Destination", inManagedObjectContext: context) as! Destination
        destination.name = self.destinationField.text
        destination.lat = self.mapView.region.center.latitude
        destination.lon = self.mapView.region.center.longitude
        destination.latDelta = self.mapView.region.span.latitudeDelta
        destination.lonDelta = self.mapView.region.span.longitudeDelta
        
        context.save(nil)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func findMe(sender: AnyObject) {
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        self.locationManager.delegate = self
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
}

