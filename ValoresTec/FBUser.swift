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
    var picture : UIImage
    
    
    init () {
        self.pictureUrl = ""
        self.firstName = ""
        self.lastName = ""
        self.picture = UIImage()
    }
}