//
//  FBUser.swift
//  ValoresTec
//
//  Created by Carlos Guerrero on 4/11/15.
//  Copyright (c) 2015 vertex. All rights reserved.
//

import Foundation


class FBUser {
    
    var pictureUrl : String
    var firstName : String
    var lastName : String
    var fbId : String
    var picture : UIImage
    var hasInnovation : Bool
    var hasHumanSense : Bool
    var hasGlobalVision: Bool
    var values : PFObject
    
    init () {
        self.pictureUrl = ""
        self.firstName = ""
        self.lastName = ""
        self.fbId = ""
        self.picture = UIImage()
        self.hasGlobalVision = false
        self.hasHumanSense = false
        self.hasInnovation = false
        self.values = PFObject(className: "Values")
    }
}