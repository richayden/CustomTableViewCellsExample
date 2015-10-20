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

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
   }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Show a spinner while we are loading the crafts.
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
        
        // Have the network manager load the crafts.
        let networkManager = NetworkManager()
        networkManager.delegate = self
        networkManager.loadCrafts()
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

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCell", forIndexPath: indexPath)

        // Configure the cell...
        let dataManager = DataManager.sharedInstance
        let craft = dataManager.getCraftAtIndex(indexPath.row)
        if let craft_ = craft, textLabel_ = cell.textLabel {
            textLabel_.text = craft_.title
            
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