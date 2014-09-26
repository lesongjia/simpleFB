//
//  AllUsersTableViewController.swift
//  simpleFB
//
//  Created by LESONG JIA on 9/24/14.
//  Copyright (c) 2014 LESONG JIA. All rights reserved.
//

import UIKit

class AllUsersTableViewController: UITableViewController {
    
    var userList : Array<User> = []

    var data = NSMutableData()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0)
        startConnection()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = d()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        return userList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel?.text = self.userList[indexPath.row].name
        cell.tag = indexPath.row

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if let newViewController = segue.destinationViewController as? UserDetailViewController {
            let cell = sender as UITableViewCell
            newViewController.setUser(userList[cell.tag])
        }
    }
    
    
    func startConnection(){
        println("start connection in dataservice")
        data = NSMutableData()
        userList = []
        let urlPath: String = "http://lesongjia.com/pingitup/server/service/getAllUsers.php"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url, cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 60.0)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        println("appending data")
        self.data.appendData(data)
    }
    
    func connection(connection: NSURLConnection!, willCacheResponse cachedResponse: NSCachedURLResponse) -> NSCachedURLResponse! {
        println("cached nil")
        return nil
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("finished!")
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as Array<NSDictionary>
        for user in jsonResult {
            var newUser = User()
            newUser.id = user["id"] as? NSString
            newUser.name = user["name"] as? NSString
            newUser.email = user["email"] as? NSString
            userList.append(newUser)
        }
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    }


}
