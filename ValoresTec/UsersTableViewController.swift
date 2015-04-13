//
//  UsersTableViewController.swift
//  ValoresTec
//
//  Created by Carlos Guerrero on 3/12/15.
//  Copyright (c) 2015 vertex. All rights reserved.
//

import UIKit

class UsersTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var usersTable: UITableView!
    var users : Dictionary <String, FBUser> = Dictionary<String, FBUser>()
    var friendsId = Array<String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usersTable.delegate = self
        self.usersTable.dataSource = self
        self.searchFacebook()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
    func searchFacebook() {
     
        var completionHandler = {
            connection, result, error in
            
            var data = NSJSONSerialization.dataWithJSONObject(result, options: .allZeros, error: nil)
            self.deserializeFbData(data!)

            
            } as FBRequestHandler;
        
        FBRequestConnection.startWithGraphPath(
            "me/friends?fields=picture,first_name,last_name",
            completionHandler: completionHandler
        );
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UserTableViewCell
        var user = Array(self.users)[indexPath.row].1
        cell.userFullName.text = user.firstName + " " + user.lastName
        cell.userPicture.image = user.picture
        
        if(user.hasGlobalVision) {
            cell.globalVision.alpha = 1.0
        }
        
        if(user.hasHumanSense) {
            cell.humanSense.alpha = 1.0
        }
        
        if(user.hasInnovation) {
            cell.innovation.alpha = 1.0
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var selectedUser = Array(self.users)[indexPath.row].1
        var parseSelectedUser = selectedUser.values
        parseSelectedUser["Innovation"] = true
        parseSelectedUser.saveInBackgroundWithBlock { (saved, error) -> Void in
            if (error != nil) {
                print(error)
            }
        }
        print(parseSelectedUser)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func deserializeFbData(data : NSData) {
        let json = JSON(data : data)
        let friends = json["data"]
        for friend in friends {
            
            var friendData = friend.1
            var user = FBUser()
            
            if let firstName = friendData["first_name"].string {
                user.firstName = firstName
                println(firstName)
            }
            
            if let lastName = friendData["last_name"].string {
                user.lastName = lastName
            }
            
            if let pictureUrl  = friendData["picture"]["data"]["url"].string {
                user.pictureUrl = pictureUrl
            }
            
            if let fbId = friendData["id"].string {
                user.fbId = fbId
                friendsId.append(fbId)
                print(fbId)
                self.users[fbId] = user
            }

        }
        self.fetchFriendStatus()
        self.fetchImages()
    }
    
    func fetchImages () {
    
        for user in self.users {
        
            var imgURL: NSURL = NSURL(string: user.1.pictureUrl)!
            
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse!,data: NSData!,error: NSError!) -> Void in
                if error == nil {
                    user.1.picture = UIImage(data: data)!
                    self.usersTable.reloadData()
                }
                else {
                    println("Error: \(error.localizedDescription)")
                }
            })
        }
    }
    
    func fetchFriendStatus () {
    
        var query = PFQuery(className:"Values")
        query.whereKey("FacebookId", containedIn: self.friendsId)
        query.findObjectsInBackgroundWithBlock { (result, error) -> Void in
            if (error == nil) {
                for tempUser in result {
                    var facebookId : String = tempUser["FacebookId"] as String
                    var temp = self.users[facebookId]!
                    temp.hasGlobalVision = tempUser["GlobalVision"] as Bool
                    temp.hasHumanSense = tempUser["HumanSense"] as Bool
                    temp.hasInnovation = tempUser["Innovation"] as Bool
                    temp.values = tempUser as PFObject
                }
                self.usersTable.reloadData()

            }
        }
    }
    
    func setValue(){
        
    }
}
