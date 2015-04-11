//
//  FBUser.swift
//  ValoresTec
//
//  Created by Carlos Guerrero on 4/11/15.
//  Copyright (c) 2015 vertex. All rights reserved.
//

import Foundation


class FBUser {
    
    var picture : String
    var firstName : String
    var lastName : String
    
    init(picture : String, firstName : String, lastName : String) {
        
        self.picture = picture
        self.firstName = firstName
        self.lastName = lastName
    }
    
}