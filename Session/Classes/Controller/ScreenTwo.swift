//
//  ScreenTwo.swift
//  Session
//
//  Created by Dharmesh  on 08/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

protocol ScreenTwoDelegate {
    
    func screenTwoValues( values : NSDictionary )
}

class ScreenTwo : UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var userType : UserMode!
    
    var delegateScreenTwo : ScreenOne?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgCoverImage: UIImageView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var toolbarResponderController: UIToolbar!
    
    @IBOutlet weak var txtFirstName: UITextField!
    
    var imagePickerController :UIImagePickerController!
    
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
    
    //------------------------------------------------------
    
    func saveItemTapped( sender : UIBarButtonItem) {
        
        //check validation and check
        let strFirstName = self.txtFirstName.text
        
        if !isEmptyString(strFirstName!) {
            self.delegateScreenTwo?.screenTwoValues( [ kFirstName : strFirstName!] );
        }
        
        self.navigationController!.popViewControllerAnimated(true);
    }
    
    //-----------------------------------------------------
    
    //MARK: UIAction Method
    
    @IBAction func prevItemTapped(snder : UIBarButtonItem) {
        
        let currentResponder = self.view.currentFirstResponder() as! UITextField
        let nextResponder = self.view.viewWithTag(currentResponder.tag-1) as? UITextField;
        
        guard (nextResponder != nil) else {
            
            self.scrollView .endEditing(true);
            return;
        }
        
        nextResponder?.becomeFirstResponder()
    }
    
    //-----------------------------------------------------
    
    @IBAction func nextItemTapped(snder : UIBarButtonItem) {
        
        let currentResponder = self.view.currentFirstResponder() as! UITextField
        let nextResponder = self.view.viewWithTag(currentResponder.tag+1) as? UITextField;
        
        guard (nextResponder != nil) else {
            
            self.scrollView .endEditing(true);
            return;
        }
        
        nextResponder?.becomeFirstResponder()
    }
    
    //-----------------------------------------------------
    
    @IBAction func doneItemTapped(snder : UIBarButtonItem) {
        self.scrollView .endEditing(true);
    }
    
    //------------------------------------------------------
    
    @IBAction func editProfileTapped(sender: AnyObject) {
        
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self;
        
        let alertController = UIAlertController(title: "Albums", message: "Pick or Capture Image", preferredStyle: .ActionSheet)
        
        let actionCamera = UIAlertAction(title: "Camera", style: .Default) { ( actionCamera : UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                
                self.imagePickerController.sourceType = .Camera
                self.presentViewController(self.imagePickerController, animated: true) { () -> Void in
                }
                
            } else {
                print("Please attached Camera")
            }
        }
        
        let actionGallery = UIAlertAction(title: "Gallery", style: .Default) { ( actionCamera : UIAlertAction) -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                
                self.imagePickerController.sourceType = .PhotoLibrary
                self.presentViewController(self.imagePickerController, animated: true) { () -> Void in
                }
            } else {
                print("Having problem to load Gallery")
            }
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .Destructive) { ( actionCamera : UIAlertAction) -> Void in
            
        }
        
        alertController .addAction(actionCamera)
        alertController .addAction(actionGallery)
        alertController.addAction(actionCancel)
        
        self .presentViewController(alertController, animated: true) { () -> Void in
        }
    }
   
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        print(info);
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.imgCoverImage.image = originalImage
        self .dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
    }
    

    //------------------------------------------------------
    
    //MARK: UITextField Delegate
   
    func textFieldDidBeginEditing(textField: UITextField) {
    
        /*let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        
        let prevItem = UIBarButtonItem(title: "Prev", style: .Plain, target: self, action: "prevItemTapped:")
    
        let nextItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "nextItemTapped:")
 
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
 
        let doneItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneItemTapped:")
 
        toolBar.setItems( [prevItem, nextItem, flexibleItem, doneItem] as [UIBarButtonItem], animated: false);*/
        
        textField.inputAccessoryView = self.toolbarResponderController;
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
        
        let saveNavigationItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveItemTapped:")
        
        self.navigationItem.rightBarButtonItems = [rightNavigationItem, saveNavigationItem] as [UIBarButtonItem];
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
}