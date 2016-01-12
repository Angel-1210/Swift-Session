//
//  ViewController.swift
//  Session
//
//  Created by Dharmesh  on 08/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import Foundation
import UIKit

class ScreenOne : UIViewController, UITableViewDelegate, UITableViewDataSource, ScreenTwoDelegate {

    @IBOutlet weak var tblList: UITableView!
    
    var arrListUsers : NSMutableArray = [ [kFirstName : "Dharmesh", kShortName : "Dharma", kLastName : "Avaiya", kJoiningAt : NSDate(), kReleventExp : "3"],
        [kFirstName : "Tejas", kShortName : "Tej", kLastName : "Joshi", kJoiningAt : NSDate(), kReleventExp : "1"]]
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //------------------------------------------------------
    
    //MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1;
    }
    
    //------------------------------------------------------
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 2;
        return self.arrListUsers.count;
    }
    
    //------------------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ScreenOneCell")!
        
        let currentItem = self.arrListUsers[indexPath.row] as! NSDictionary
        
        cell.textLabel?.text = currentItem.objectForKey(kFirstName) as? String
        
        return cell;
        
    }
    
    //------------------------------------------------------    
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    //MAKR: ScreenTwoDelegate 
    
    func screenTwoValues( values : NSDictionary ) {
        
        self.arrListUsers.addObject(values)
        print(self.arrListUsers)
        self.tblList .reloadData()
        
    }
    
    //MARK: UIVIew Life Cycle
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let controller = segue.destinationViewController as! ScreenTwo
        controller.userType = UserMode.UserModeAdd
        controller.delegateScreenTwo = self;
        
    }
    
    //------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
}

