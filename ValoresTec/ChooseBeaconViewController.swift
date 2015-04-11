//
//  ChooseBeaconViewController.swift
//  ValoresTec
//
//  Created by Carlos Guerrero on 3/12/15.
//  Copyright (c) 2015 vertex. All rights reserved.
//

import UIKit
import CoreLocation

class ChooseBeaconViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    let region =
        CLBeaconRegion(proximityUUID: NSUUID(UUIDString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D"), identifier: "Estimotes")
    
    let values : [String: String] = ["57216": "Innovación", "49231": "Integridad", "58576": "Sentido humano"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self;
        locationManager.requestAlwaysAuthorization()
        if (CLLocationManager.authorizationStatus() != CLAuthorizationStatus.Authorized) {
            locationManager.requestAlwaysAuthorization()
        }
        locationManager.startRangingBeaconsInRegion(region)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons: [AnyObject]!, inRegion region: CLBeaconRegion!) {
        
        if(beacons.count > 0) {
            var nearestBeacon = beacons[0] as CLBeacon
            nearestBeacon.major
            if  nearestBeacon.proximity == CLProximity.Immediate {
                self.handleValue("\(nearestBeacon.major)")
            }
        }
    }
    
    func handleValue (id : String) {
        var alert = UIAlertController(title: "Valor de \(values[id]!) fue encontrado!",
            message: "¿Deseas asignar el valor?", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Si", style: UIAlertActionStyle.Default, handler: { alertAction in
            alert.dismissViewControllerAnimated(true, completion: nil)
            let vc = self.storyboard!.instantiateViewControllerWithIdentifier("UsersTable") as UsersTableViewController
            self.presentViewController(vc, animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "No gracias", style: UIAlertActionStyle.Default, handler: { alertAction in
            print("no")
            alert.dismissViewControllerAnimated(true, completion: nil)
        }))

        self.presentViewController(alert, animated: true, completion: nil)
    }
}
