//
//  DataService.swift
//  simpleFB
//
//  Created by LESONG JIA on 9/24/14.
//  Copyright (c) 2014 LESONG JIA. All rights reserved.
//
import UIKit

class DataService :UIViewController, NSURLConnectionDelegate{
   var data = NSMutableData()
   
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func startConnection(){
        println("start connection in dataservice")
        let urlPath: String = "http://lesongjia.com/pingitup/server/service/getAllUsers.php"
        var url: NSURL = NSURL(string: urlPath)
        var request: NSURLRequest = NSURLRequest(URL: url)
        var connection: NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: false)
        connection.start()
    }
    
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        println("appending data")
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!) {
        println("finished!")
        var err: NSError
        // throwing an error on the line below (can't figure out where the error message is)
        var jsonResult = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: nil) as Array<NSDictionary>
        println(jsonResult)
    }
 
}
