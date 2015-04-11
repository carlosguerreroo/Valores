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
    var users = Array<PFObject>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.usersTable.delegate = self
        self.usersTable.dataSource = self
        self.getUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func getUsers(){
        var query = PFQuery(className:"User")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                if let users = objects as? [PFObject] {
                    for user in users {
                        var id = user.objectId
                        print("este es el id: \(id)")
                        self.users.append(user)
                    }
                    self.usersTable.reloadData()
                }
            } else {
                println("Error: \(error) \(error.userInfo!)")
            }
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        var user = self.users[indexPath.row]
        var name: AnyObject! = user.objectId
        cell.textLabel!.text = "\(name)"
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
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
