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
    var users = Array<FBUser>()
    
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
        
        // Request the profile info
        FBRequestConnection.startWithGraphPath(
            "me/friends?fields=picture,first_name,last_name",
            completionHandler: completionHandler
        );
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var user = self.users[indexPath.row]
//        var name: AnyObject! = user.objectId
//        cell.textLabel!.text = "\(name)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func deserializeFbData(data : NSData) {
        let json = JSON(data : data)
        
        let friends = json["data"]
        for friend in friends {
            
            var friendData = friend.1
            var user =  FBUser()
            if let firstName = friendData["first_name"].string {
                user.firstName = firstName
            }
            
            if let lastName = friendData["last_name"].string {
                user.lastName = lastName
            }
            
            if let picture  = friendData["picture"]["data"]["url"].string {
                user.picture = picture
            }
            self.users.append(user)
        }        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
