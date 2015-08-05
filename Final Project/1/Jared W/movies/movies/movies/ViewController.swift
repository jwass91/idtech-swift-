//
//  ViewController.swift
//  movies
//
//  Created by iD Student on 7/23/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource {

    
    
    let viewModel = ViewModel()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
        
        viewModel.fetchItems { () -> () in
            dispatch_async(dispatch_get_main_queue()){
                self.tableView.reloadData()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItemsInSection(section)
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
    configureCell(cell, atIndexPath: indexPath)
        return cell
    }
    func configureCell(cell: UITableViewCell, atIndexPath indexPath:NSIndexPath){
    cell.textLabel!.text = viewModel.titleForItemsAtIndexPath(indexPath)
    }

}

