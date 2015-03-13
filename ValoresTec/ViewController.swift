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
        print("sa")
        PFFacebookUtils.logInWithPermissions(["publish_actions"], {
            (user: PFUser!, error: NSError!) -> Void in
                        
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
            } else if user.isNew {
                NSLog("User signed up and logged in through Facebook!")
                self.openChooseBadge()
            } else {
                NSLog("User logged in through Facebook!")
                self.openChooseBadge()
            }
        })
    }
    
}

