//
//  BaseVC.swift
//  Session
//
//  Created by Dharmesh  on 17/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit
import Foundation

class BaseVC : UIViewController {
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Custom Methods
    
    //------------------------------------------------------
    
    func DisplayAlertWithTitle( title : String, message : String) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        let alertActionOk = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alertController .addAction(alertActionOk)
        
        self .presentViewController(alertController, animated: true, completion: nil)
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
