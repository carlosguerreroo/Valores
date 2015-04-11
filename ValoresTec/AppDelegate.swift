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
        Parse.setApplicationId("S9M8GvHaVy4F8z79tgxmXcOCuTh0B7GXt14cYLHD", clientKey: "duxFXqnpNwtizDCHYfGCLG8HEew1Lh1Hzhrao95d")
        var object = PFObject(className: "testDataClass")
        PFFacebookUtils.initializeFacebook()
        PFAnalytics.trackAppOpenedWithLaunchOptionsInBackground(launchOptions, block: nil)
        
        if PFUser.currentUser() != nil{
//            let menuViewController = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("ChooseBeacon") as ChooseBeaconViewController
             let menuViewController = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier("UsersTable") as UsersTableViewController
            self.window?.rootViewController? = menuViewController
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
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }

    func applicationWillTerminate(application: UIApplication) {
    }
    
    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
                withSession:PFFacebookUtils.session())
    }



}

