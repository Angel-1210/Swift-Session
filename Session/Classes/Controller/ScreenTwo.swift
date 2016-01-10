//
//  ScreenTwo.swift
//  Session
//
//  Created by Dharmesh  on 10/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class ScreenTwo : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    //MARK: Memory Management Method
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //-----------------------------------------------------
    
    //MARK: Custom Method
    
    func rightItemTapped( sender : UIBarButtonItem ) {
        
        if(sender.title == "Edit") {
            sender.title = "Done"
            
            let subViews = self.scrollView.subviews
            for subview in subViews{
                subview.userInteractionEnabled = true;
            }
            
        } else {
            
            sender.title = "Edit"
            let subViews = self.scrollView.subviews
            for subview in subViews{
                subview.userInteractionEnabled = false;
            }

        }
    }
    
    //-----------------------------------------------------
    
    func prevItemTapped(snder : UIBarButtonItem) {
        
        let currentResponder = self.view.currentFirstResponder() as! UITextField
        let nextResponder = self.view.viewWithTag(currentResponder.tag-1) as? UITextField;
        
        guard (nextResponder != nil) else {
            
            self.scrollView .endEditing(true);
            return;
        }
        
        nextResponder?.becomeFirstResponder()
    }
    
    //-----------------------------------------------------
    
    func nextItemTapped(snder : UIBarButtonItem) {
        
        let currentResponder = self.view.currentFirstResponder() as! UITextField
        let nextResponder = self.view.viewWithTag(currentResponder.tag+1) as? UITextField;
        
        guard (nextResponder != nil) else {
            
            self.scrollView .endEditing(true);
            return;
        }
        
        nextResponder?.becomeFirstResponder()
    }
    
    //-----------------------------------------------------
    
    func doneItemTapped(snder : UIBarButtonItem) {
        self.scrollView .endEditing(true);
    }
    
    //------------------------------------------------------
    
    //MARK: UITextField Delegate
   
    func textFieldDidBeginEditing(textField: UITextField) {
    
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        
        
        let prevItem = UIBarButtonItem(title: "Prev", style: .Plain, target: self, action: "prevItemTapped:")
    
        let nextItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "nextItemTapped:")
 
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
 
        let doneItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneItemTapped:")
 
        toolBar.setItems( [prevItem, nextItem, flexibleItem, doneItem] as [UIBarButtonItem], animated: false);
        
        textField.inputAccessoryView = toolBar;
    }
    
    //-----------------------------------------------------
    
    //MARK: NSNotification
    
    func keyboardWasShown(notification: NSNotification) {
        
        var info = notification.userInfo!
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        self.scrollView.contentInset = contentInset
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            //self.bottomConstraint.constant += keyboardFrame.size.height + 20
        })
    }

    //------------------------------------------------------
    
    func keyboardWillHide(notification : NSNotificationCenter) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInset
    }
    
    //------------------------------------------------------
    
    //MARK: UIVIew Life Cycle
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let subViews = self.scrollView.subviews
        for subview in subViews{
            subview.userInteractionEnabled = false;
        }
        
        self.imgProfile.layer.borderWidth = 5;
        self.imgProfile.layer.borderColor = UIColor.whiteColor().CGColor;
        self.imgProfile.layer.cornerRadius = 25.0;
        self.imgProfile.clipsToBounds = true;
        
        let rightNavigationItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "rightItemTapped:")
        
        self.navigationItem.rightBarButtonItem = rightNavigationItem;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
}