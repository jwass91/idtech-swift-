/*

This work is licensed under a Creative Commons Attribution-NonCommercial-ShareAlike
4.0 International License, by Yong Bakos.

*/

import UIKit
import MapKit
class ViewController: UIViewController, MKMapViewDelegate {
    
    @IBAction func thunderPin(sender: AnyObject) {
        let pin = Pin(coordinate: Map.userLocation.coordinate)
        Map.addAnnotation(pin)
        
    }
    @IBOutlet var Map: MKMapView!{
        didSet {
         Map.mapType = .Hybrid
        Map.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Map.setUserTrackingMode(.Follow, animated: true)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(mapView: MKMapView!, didUpdateUserLocation userLocation: MKUserLocation!) {
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        let width = 10.0
        let height = 10.0
        let region = MKCoordinateRegionMakeWithDistance(center, width, height)
        Map.setRegion(region, animated: true)
    }
    

}

