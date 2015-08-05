//
//  ViewModel.swift
//  movies
//
//  Created by iD Student on 7/23/15.
//  Copyright (c) 2015 Jared Wasserman. All rights reserved.
//

import Foundation

class ViewModel {
    let urlString = "https://itunes.apple.com/us/rss/topfreeapplications/limit=50/json"
    var titles = [String]()
    
    func fetchItems(success: () -> ()){
        let url = NSURL(string: urlString)
        let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
        let task = session.dataTaskWithURL(url!) {(data, response, error) in
        
        var jsonError = NSError?()
        let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &jsonError) as! NSDictionary
            
        if let unwrappedError = jsonError {
        println("json error: \(unwrappedError)")
        }else{
            self.titles = json.valueForKeyPath("feed.entry.im:name.label") as! [String]
            success()
        }
    }
    
    task.resume()
        
    }
    func numberOfSections() -> Int{
        return 1
    }
    func numberOfItemsInSection(section: Int) -> Int{
        return titles.count
    }
    func titleForItemsAtIndexPath(indexPath: NSIndexPath) -> String{
        return titles[indexPath.row]
    }

}