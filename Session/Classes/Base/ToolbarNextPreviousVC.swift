//
//  ToolbarNextPreviousVC.swift
//  Session
//
//  Created by Dharmesh  on 16/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit
import Foundation

@objc protocol ToolbarNextPreviousDelegate {
    
    optional func prevItemTapped(sender: UIBarButtonItem)
    
    optional func nextItemTapped(sender: UIBarButtonItem)
    
    optional func doneItemTapped(sender: UIBarButtonItem)
}

class ToolbarNextPreviousVC : UIViewController {
    
    //MARK: Memory Management Method
    
    var delegate : ToolbarNextPreviousDelegate?
    
    @IBOutlet var toolbarNextPrevious: UIToolbar!
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }
    
    //------------------------------------------------------
    
    //MARK: Action Methods
    
    @IBAction func prevItemTapped(sender: UIBarButtonItem) {
        
        self.delegate? .prevItemTapped!(sender)
    }

    //------------------------------------------------------
    
    @IBAction func nextItemTapped(sender: UIBarButtonItem) {
        
        self.delegate? .nextItemTapped!(sender)
    }
    
    //------------------------------------------------------
    
    @IBAction func doneItemTapped(sender: UIBarButtonItem) {
        
        self.delegate? .doneItemTapped!(sender)
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
