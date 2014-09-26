//
//  ViewController.swift
//  simpleFB
//
//  Created by LESONG JIA on 9/22/14.
//  Copyright (c) 2014 LESONG JIA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, FBLoginViewDelegate {

    @IBOutlet var welcomeLabel: UILabel!
    @IBOutlet var fbLoginView : FBLoginView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var allUsersBtn: UIBarButtonItem!
    
    var data = NSMutableData()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.fbLoginView.delegate = self
        self.fbLoginView.readPermissions = ["public_profile", "email", "user_friends"]
        self.allUsersBtn.enabled = false
        self.navigationController
    }
    
    func loginViewShowingLoggedInUser(loginView : FBLoginView!) {
        println("User Logged In")
        loginAction()
    }
    
    func loginViewFetchedUserInfo(loginView : FBLoginView!, user: FBGraphUser) {
        println("User: \(user)")
        println("User ID: \(user.objectID)")
        println("User Name: \(user.name)")
        let userEmail = user.objectForKey("email") as String
        println("User Email: \(userEmail)")
        self.nameLabel.text = user.name
        self.emailLabel.text = userEmail
        
        let stringUrl = "http://graph.facebook.com/v2.1/" + user.objectID + "/picture?type=large";
        let url = NSURL.URLWithString(stringUrl)
        let imageData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
        self.profileImg.image = UIImage(data: imageData)
        self.profileImg.reloadInputViews()
        saveUser(user.objectID, name: user.name, email: userEmail)
        
    }
    
    func loginViewShowingLoggedOutUser(loginView : FBLoginView!) {
        println("User Logged Out")
        logoutAction()
    }
    
    func loginView(loginView : FBLoginView!, handleError:NSError) {
        println("Error: \(handleError.localizedDescription)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func saveUser(id : String, name : String, email : String){
        println("start connection in dataservice")
        data = NSMutableData()
        var nameAfterEncoding = name.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        var urlPath = "http://lesongjia.com/pingitup/server/service/saveUser.php?userId=\(id)&name=\(nameAfterEncoding)&email=\(email)"
        println(urlPath)
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
    }

    func loginAction() {
        self.allUsersBtn.enabled = true
        self.welcomeLabel.hidden = false
    }
    
    func logoutAction() {
        self.allUsersBtn.enabled = false
        self.welcomeLabel.hidden = true
        self.nameLabel.text = ""
        self.emailLabel.text = ""
        self.profileImg.image = nil
    }
}

