//
//  SettingsVC.swift
//  Session
//
//  Created by Dharmesh  on 16/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit
import Foundation

class SettingsVC : UIViewController {
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action Method
    
    @IBAction func btnLogoutTapped(sender: UIButton) {
        
        AppDelegate.singleton().setupLoginController()
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}

