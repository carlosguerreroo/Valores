//
//  UserTableViewCell.swift
//  ValoresTec
//
//  Created by Carlos Guerrero on 4/11/15.
//  Copyright (c) 2015 vertex. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userPicture: UIImageView!
    @IBOutlet weak var userFullName: UILabel!
    @IBOutlet weak var innovation: UIImageView!
    @IBOutlet weak var globalVision: UIImageView!
    @IBOutlet weak var humanSense: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.userPicture.layer.cornerRadius = self.userPicture.frame.size.width/2
        self.userPicture.clipsToBounds = true

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
