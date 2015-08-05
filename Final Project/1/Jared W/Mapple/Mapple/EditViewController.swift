import UIKit
import MapKit
import CoreData

class EditViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var textField: UITextField!
    var destination: Destination!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        textField.text = destination.name
        
        let lat = destination.lat as! Double
        let lon = destination.lon as! Double
        let latDelta = destination.latDelta as! Double
        let lonDelta = destination.lonDelta as! Double
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        let span = MKCoordinateSpanMake(latDelta, lonDelta)
        let region = MKCoordinateRegionMake(location, span)
        mapView.setRegion(region, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelEdit(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveEdit(sender: AnyObject) {
        saveLoginData(destination.name, newName: textField.text)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveLoginData(name: String, newName: String) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var fetchRequest = NSFetchRequest(entityName: "Destination")
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        
        if let fetchResults = context.executeFetchRequest(fetchRequest, error: nil) as? [NSManagedObject] {
            if fetchResults.count != 0 {
                var managedObject = fetchResults[0]
                managedObject.setValue(newName, forKey: "name")
                context.save(nil)
            }
        }
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
}
