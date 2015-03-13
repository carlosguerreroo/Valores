//
//  AppDelegate.swift
//  ValoresTec
//
//  Created by Carlos Guerrero on 3/12/15.
//  Copyright (c) 2015 vertex. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        Parse.setApplicationId("TLVyCdn7UPa6GCWOuG9h5rUzuYCT8BfuGBHhKYNI", clientKey: "JJ5XOIMKpeF0GyaXaWscPJ1UOMgRWHWVaBDsJM2V")
        var object = PFObject(className: "testDataClass")
        PFFacebookUtils.initializeFacebook()
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        if PFUser.currentUser() != nil{
//            let menuViewController = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("NavigationSearchController") as NavigationSearchController
//            self.window?.rootViewController? = menuViewController
        }
        

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }


}

