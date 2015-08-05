//
//  maptableviewcontroller.swift
//  Mapple
//
//  Created by iD Student on 7/21/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class maptableviewcontroller: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var mapView: UITableView!
    var destinations: [Destination] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.mapView.dataSource = self
//        createTestTrack()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func createTestTrack() {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var favDestination = NSEntityDescription.insertNewObjectForEntityForName("Destination", inManagedObjectContext: context) as! Destination
        favDestination.name = "Rome"
        favDestination.lat = 41.904194
        favDestination.lon = 12.497546
        favDestination.latDelta = 2.5
        favDestination.lonDelta = 2.5
        context.save(nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        var context = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext!
        var request = NSFetchRequest(entityName: "Destination")
        self.destinations = context.executeFetchRequest(request, error: nil) as! [Destination]
        self.mapView.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("edit", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "edit") {
            let navigation = segue.destinationViewController as! UINavigationController
            let edit = navigation.topViewController as! EditViewController
            let indexPath = self.mapView.indexPathForSelectedRow()
            edit.destination = self.destinations[indexPath!.row]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return self.destinations.count
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.destinations.count
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var destination = self.destinations[indexPath.row]
        var cell = mapView.dequeueReusableCellWithIdentifier("mapCell") as! mapCell
        cell.label.text = destination.name
        var coordinate = CLLocationCoordinate2DMake(destination.lat.doubleValue, destination.lon.doubleValue)
        var span = MKCoordinateSpanMake(destination.latDelta.doubleValue, destination.lonDelta.doubleValue)
        var region = MKCoordinateRegionMake(coordinate, span)
        
        cell.map.setRegion(region, animated: true)
        
        // Configure the cell...
        
        
        return cell
    }

    
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }


    
    // Override to support editing the table view.
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            //return self.destinations.count
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
