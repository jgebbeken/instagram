//
//  ViewController.swift
//  instagram
//
//  Created by Josh Gebbeken on 1/27/16.
//  Copyright © 2016 Josh Gebbeken. All rights reserved.
//

import UIKit
import AFNetworking

class photoViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var data: [NSDictionary]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 320;
        
        
        let clientId = "e05c462ebd86446ea48a5af73769b602"
        let url = NSURL(string:"https://api.instagram.com/v1/media/popular?client_id=\"(e05c462ebd86446ea48a5af73769b602)")
        let request = NSURLRequest(URL: url!)
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate:nil,
            delegateQueue:NSOperationQueue.mainQueue()
        )
        
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request,
            completionHandler: { (dataOrNil, response, error) in
                if let data = dataOrNil {
                    if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(
                        data, options:[]) as? NSDictionary {
                            NSLog("response: \(responseDictionary)")
                    }
                }
        });
        task.resume()
        
        tableView.reloadData()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cardView", forIndexPath: indexPath) as! PhotoCell
        
        
        let post = data![indexPath.section]
        let photo = post["images"]!["low_resolution"]!!["url"] as! String
        let imgurl = NSURL(string: photo)!
      //  cell.photoView.setImageWithURL(imgurl)
        
        return cell
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        if let data = data {
            return data.count
        }else {
            return 0
        }
    }

}

