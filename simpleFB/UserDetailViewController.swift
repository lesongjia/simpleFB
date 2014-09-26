//
//  UserDetailViewController.swift
//  simpleFB
//
//  Created by LESONG JIA on 9/24/14.
//  Copyright (c) 2014 LESONG JIA. All rights reserved.
//

import UIKit

class UserDetailViewController: UIViewController {

    @IBOutlet var navBar: UINavigationItem!
    @IBOutlet var profileImg: UIImageView!
    var currentUser = User()
    
    @IBOutlet var email: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initWithUser()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initWithUser() {
        email.text = currentUser.email
        self.navBar.title = currentUser.name
        var userId = currentUser.id as String
        
        let stringUrl = "http://graph.facebook.com/v2.1/" + userId + "/picture?type=large";
        let url = NSURL.URLWithString(stringUrl)
        let imageData = NSData.dataWithContentsOfURL(url, options: nil, error: nil)
        self.profileImg.image = UIImage(data: imageData)
        self.profileImg.reloadInputViews()
    }

    func setUser(user : User) {
        currentUser.id = user.id
        currentUser.name = user.name
        currentUser.email = user.email
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
