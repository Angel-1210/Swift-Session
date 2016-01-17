//
//  SignUpVC.swift
//  Session
//
//  Created by Dharmesh  on 17/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit
import Foundation

class SignUpVC : BaseVC, ToolbarNextPreviousDelegate {
    
    var toolBarNextPreviousItems : UIToolbar!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    //MARK: Memory Management Method    
    
    override func didReceiveMemoryWarning() {
        
    }
    
    //------------------------------------------------------
    
    deinit { //same like dealloc in ObjectiveC
        
    }

    //------------------------------------------------------

    //MARK: Action Method
    
    @IBAction func btnSignUpTapped(sender: UIButton) {
        
        let username = self.txtUsername.text! as String
        let password = self.txtPassword.text! as String
        
        if isEmptyString(username) {
            
            self .DisplayAlertWithTitle("Username", message: "Please enter Username")
            return
        }

        if isEmptyString(password) {
            
            self .DisplayAlertWithTitle("Password", message: "Please enter Password")
            return
        }
        
        let result = SQLiteManager.singleton().find(kUserName, from: kTableUser, `where`: "\(kUserName) LIKE '\(username)'") as NSArray
        
        if result.count > 0 {
            self .DisplayAlertWithTitle("User", message: "User is already exist")
            return
        }
        
        let dictValues = NSMutableDictionary()
        
        dictValues.setObject( username, forKey: kUserName)
        dictValues.setObject( password, forKey: kPassword)
        
        SQLiteManager .singleton().save(dictValues, into: kTableUser)
        AppDelegate .singleton().setupControllers()
    }
    
    //------------------------------------------------------
    
    //MARK: UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
        textField.inputAccessoryView = self.toolBarNextPreviousItems;
    }
    
    //------------------------------------------------------
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        self.nextItemTapped(UIBarButtonItem())
        return true;
    }
    
    //------------------------------------------------------
    
    //MARK: ToolbarNextPreviousDelegate
    
    func prevItemTapped(sender: UIBarButtonItem) {
        
        let currentResponder = self.view.currentFirstResponder() as! UITextField
        let nextResponder = self.view.viewWithTag(currentResponder.tag-1) as? UITextField;
        
        guard (nextResponder != nil) else {
            
            self.view .endEditing(true);
            return;
        }
        
        nextResponder?.becomeFirstResponder()
        
    }
    
    //------------------------------------------------------
    
    func nextItemTapped(sender: UIBarButtonItem) {
        
        let currentResponder = self.view.currentFirstResponder() as! UITextField
        
        let nextResponder = self.view.viewWithTag(currentResponder.tag+1) as? UITextField;
        
        guard (nextResponder != nil) else {
            
            self.view .endEditing(true);
            return;
        }
        
        nextResponder?.becomeFirstResponder()
    }
    
    //------------------------------------------------------
    
    func doneItemTapped(sender: UIBarButtonItem) {
        
        self.view .endEditing(true);
    }
    
    //-----------------------------------------------------
    
    //MARK: NSNotification
    
    func keyboardWasShown(notification: NSNotification) {
        
        var info = notification.userInfo!
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height;
        self.scrollView.contentInset = contentInset
    }
    
    //------------------------------------------------------
    
    func keyboardWillHide(notification : NSNotificationCenter) {
        
        let contentInset:UIEdgeInsets = UIEdgeInsetsZero
        self.scrollView.contentInset = contentInset
    }

    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ToolbarNextPreviousVC") as! ToolbarNextPreviousVC
        controller.delegate = self
        self.toolBarNextPreviousItems = controller.toolbarNextPrevious;
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        self.txtUsername.leftView = UIView(frame: CGRectMake(0, 0, 5, 0))
        self.txtUsername.leftViewMode = UITextFieldViewMode.Always
        
        self.txtPassword.leftView = UIView(frame: CGRectMake(0, 0, 5, 0))
        self.txtPassword.leftViewMode = UITextFieldViewMode.Always
    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //------------------------------------------------------
}
