//
//  ViewController.swift
//  ValoresTec
//
//  Created by Carlos Guerrero on 3/12/15.
//  Copyright (c) 2015 vertex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func openChooseBadge() {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let menuViewController =
        storyboard.instantiateViewControllerWithIdentifier("ChooseBeacon")
            as ChooseBeaconViewController
        
        self.presentViewController(menuViewController,
            animated: true,
            completion: nil)

    }
    
    @IBAction func loginUser(sender: AnyObject) {
        PFFacebookUtils.logInWithPermissions(["publish_actions","user_friends"], {
            (user: PFUser!, error: NSError!) -> Void in
                        
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                self.getFacebookInformation()
                self.updateUser()
                self.openChooseBadge()
            } else {
                NSLog("User logged in through Facebook!")
                self.getFacebookInformation()
                self.openChooseBadge()
            }
        })
    }
    
    func getFacebookInformation () {
        var completionHandler = {
            connection, result, error in
                var data = NSJSONSerialization.dataWithJSONObject(result, options: .allZeros, error: nil)
                self.insertFacebookId(data!)
            } as FBRequestHandler;
        
        FBRequestConnection.startWithGraphPath(
            "me",
            completionHandler: completionHandler
        );
    }
    
    func insertFacebookId (data: NSData) {
        let json = JSON(data : data)
        var facebookId = json ["id"]
        PFUser.currentUser()["facebookId"] = facebookId.string
        PFUser.currentUser().saveInBackgroundWithBlock(nil)
    }
    
    func updateUser () {
        PFUser.currentUser()["Innovation"] = false
        PFUser.currentUser()["HumanSense"] = false
        PFUser.currentUser()["GlobalVision"] = false

        PFUser.currentUser().saveInBackgroundWithBlock(nil)
    }
    
}

