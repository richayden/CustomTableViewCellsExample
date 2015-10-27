//
//  TableViewController.swift
//  CustomTableViewCellsExample
//
//  Created by Bob Pascazio on 10/15/15.
//  Copyright © 2015 Bob Pascazio. All rights reserved.
//

import UIKit
import PKHUD

class TableViewController: UITableViewController, NetworkManagerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        ///// add vvv
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: Selector("pullData"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    ///// add vvv
    func pullData() {
        
        // Show a spinner while we are loading the crafts.
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        // Have the network manager load the crafts.
        let networkManager = NetworkManager()
        networkManager.delegate = self
        networkManager.loadCrafts()
        refreshControl?.endRefreshing()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        ///// add vvv
        self.pullData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        let dataManager = DataManager.sharedInstance

        return dataManager.getCraftCount()
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCellId", forIndexPath: indexPath) as! CustomTableViewCell

        
        // Configure the cell...
        let dataManager = DataManager.sharedInstance
        let craft = dataManager.getCraftAtIndex(indexPath.row)
//        if let craft_ = craft, textLabel_ = cell.textLabel {
//            textLabel_.text = craft_.title
//        }
        if let craft_ = craft, detailLabel_ = cell.weightLabel {
            detailLabel_.text = "\(craft_.weight!)lbs"
        }
        if let craft_ = craft {
            if craft_.imageURL != "" {
                
                var data: NSData?
                
                let url = NSURL(string:craft_.imageURL!)
                data = NSData(contentsOfURL:url!)
                if data != nil {
                    cell.myImageView!.image = UIImage(data:data!)
                }
            }
        }
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - NetworkManagerDelegate
    
    func loadComplete() {
        PKHUD.sharedHUD.hide()
        tableView.reloadData()
    }

}
