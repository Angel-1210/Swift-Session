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

var constantkeyTextField = "constantkeyTextField"
var constantkeyImagePicker = "constantkeyImagePicker"

class ScreenTwo : BaseVC, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, ToolbarNextPreviousDelegate {
    
    var userType : UserMode!
    var delegateScreenTwo : ScreenTwoDelegate?
    
    var dictValues : NSDictionary?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var imgCoverImage: UIImageView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    var toolBarNextPreviousItems: UIToolbar!
    
    @IBOutlet var datePicker: UIDatePicker!
    
    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtShortName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtBornOn: UITextField!
    @IBOutlet weak var txtJoinAt: UITextField!
    @IBOutlet weak var txtReleventExp: UITextField!    
    @IBOutlet weak var imgCompnayLocation: UIImageView!
    
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
        
        //check validation
        let strFirstName = self.txtFirstName.text
        
        if isEmptyString(strFirstName!) {
         
            self .DisplayAlertWithTitle("First Name", message: "Please enter First Name")
            return            
        }
        
        let strShortName = self.txtShortName.text
        
        if isEmptyString(strShortName!) {
            
            self .DisplayAlertWithTitle("First Name", message: "Please enter Short Name")
            return
        }
        
        let strLastName = self.txtLastName.text
        
        if isEmptyString(strLastName!) {
            
            self .DisplayAlertWithTitle("First Name", message: "Please enter Last Name")
            return
        }
        
        let strBornOn = self.txtBornOn.text
        
        if isEmptyString(strBornOn!) {
            
            self .DisplayAlertWithTitle("First Name", message: "Please enter Born On")
            return
        }
        
        let strJoinAt = self.txtJoinAt.text
        
        if isEmptyString(strJoinAt!) {
            
            self .DisplayAlertWithTitle("First Name", message: "Please enter Join At")
            return
        }
        
        let strReleventExp = self.txtReleventExp.text

        var dictValuesToAdd = NSMutableDictionary()
        
        if (self.dictValues != nil) {
            dictValuesToAdd = NSMutableDictionary.init(dictionary: self.dictValues!)
        }
        
        dictValuesToAdd.setObject(strFirstName!, forKey: kFirstName)
        dictValuesToAdd.setObject(strShortName!, forKey: kShortName)
        dictValuesToAdd.setObject(strLastName!, forKey: kLastName)
        dictValuesToAdd.setObject(strBornOn!, forKey: kBornOn)
        dictValuesToAdd.setObject(strJoinAt!, forKey: kJoiningAt)
        dictValuesToAdd.setObject(strReleventExp!, forKey: kReleventExp)
        dictValuesToAdd.setObject(self.imgProfile.image!, forKey: kProfileImage)
        dictValuesToAdd.setObject(self.imgCoverImage.image!, forKey: kCoverImage)
        
        self.delegateScreenTwo?.screenTwoValues(dictValuesToAdd);
        
        self.navigationController!.popViewControllerAnimated(true);
    }

    //------------------------------------------------------
    
    func showOptionsForImagePicker(sender : UIImageView) {
        
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self;
        
        objc_setAssociatedObject(self.imagePickerController, &constantkeyImagePicker, sender, .OBJC_ASSOCIATION_ASSIGN)
        
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
    
    //------------------------------------------------------
    
    func configureValues() {
        
        self.txtFirstName.text = self.dictValues?.objectForKey(kFirstName) as? String
        self.txtShortName.text = self.dictValues?.objectForKey(kShortName) as? String
        self.txtLastName.text = self.dictValues?.objectForKey(kLastName) as? String
        self.txtBornOn.text = self.dictValues?.objectForKey(kBornOn) as? String
        self.txtJoinAt.text = self.dictValues?.objectForKey(kJoiningAt) as? String
        self.txtReleventExp.text = self.dictValues?.objectForKey(kReleventExp) as? String
        
        self.imgProfile.image = self.dictValues?.objectForKey(kProfileImage) as? UIImage
        self.imgCoverImage.image = self.dictValues?.objectForKey(kCoverImage) as? UIImage
    }
    
    //------------------------------------------------------
    
    //MARK: Action Methods
    
    //------------------------------------------------------
    
    @IBAction func editCoverTapped(sender: UIButton) {
        
        self .showOptionsForImagePicker(self.imgCoverImage)
    }
    
    //------------------------------------------------------
    
    @IBAction func editProfileTapped(sender: UIButton) {
        self .showOptionsForImagePicker(self.imgProfile)
    }
    
    //------------------------------------------------------
    
    @IBAction func locationIconTapped( sender : UITapGestureRecognizer) {
        
        let map = self.storyboard?.instantiateViewControllerWithIdentifier("MapVC") as! MapVC
        self.navigationController?.pushViewController(map, animated: true)
    }
    
    //-----------------------------------------------------
    
    //MARK: ToolbarNextPreviousDelegate
    
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
        
        let selectedTextField = objc_getAssociatedObject(self.datePicker, &constantkeyTextField) as! UITextField
        
        if selectedTextField == self.txtBornOn || selectedTextField == self.txtJoinAt {

            let dateFormatter = NSDateFormatter();
            dateFormatter.dateFormat = "dd-MM-yyyy"
            
            selectedTextField.text =  ("\(dateFormatter.stringFromDate(self.datePicker.date))")
            
            if selectedTextField == self.txtJoinAt {
                
                let calendar: NSCalendar = NSCalendar.currentCalendar()
                
                let joiningDate = calendar.startOfDayForDate(self.datePicker.date)
                let currentDate = calendar.startOfDayForDate(NSDate())
                
                let flags = NSCalendarUnit.Year
                
                let components = calendar.components(flags, fromDate: joiningDate, toDate: currentDate, options: .WrapComponents)
                
                self.txtReleventExp.text = ("\(components.year)")
            }
        }
        
        self.scrollView .endEditing(true);
    }
    
    //MARK: UIImagePickerControllerDelegate
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        let imageView = objc_getAssociatedObject(self.imagePickerController, &constantkeyImagePicker) as! UIImageView
        
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        imageView.image = originalImage
        self .dismissViewControllerAnimated(true) { () -> Void in
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

    //------------------------------------------------------
    
    //MARK: UITextField Delegate
   
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
    
        if self.txtReleventExp == textField {
            return false
        } else {
            return true
        }
    }
    
    //------------------------------------------------------
    
    func textFieldDidBeginEditing(textField: UITextField) {
    
        /*let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 44))
        
        let prevItem = UIBarButtonItem(title: "Prev", style: .Plain, target: self, action: "prevItemTapped:")
    
        let nextItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: "nextItemTapped:")
 
        let flexibleItem = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: self, action: nil)
 
        let doneItem = UIBarButtonItem(title: "Done", style: .Plain, target: self, action: "doneItemTapped:")
 
        toolBar.setItems( [prevItem, nextItem, flexibleItem, doneItem] as [UIBarButtonItem], animated: false);*/
        
        textField.inputAccessoryView = self.toolBarNextPreviousItems;
        
        if textField == self.txtBornOn || textField == self.txtJoinAt {
            
            self.datePicker.maximumDate = NSDate();
            
            textField.inputView = self.datePicker;
        }
        
        objc_setAssociatedObject(self.datePicker, &constantkeyTextField, textField, .OBJC_ASSOCIATION_ASSIGN)
    }

    //------------------------------------------------------
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        
        if string == "" {
            return true
        }
        
        
        if textField == self.txtBornOn || textField == self.txtJoinAt {
            return false
        }
        
        let stringToValidate = textField.text?.stringByAppendingString(string);
        print(stringToValidate)
        
        switch textField {
            
        case self.txtFirstName :
            return Validation .isValidName(stringToValidate!)
            
        case self.txtShortName:
            return Validation .isValidShortName(stringToValidate!)
            
        case self.txtLastName:
            return Validation .isValidName(stringToValidate!)
            
        default :
            break
        }
        
        return true;
    }
    
    //-----------------------------------------------------
    
    //MARK: NSNotification
    
    func keyboardWasShown(notification: NSNotification) {
        
        var info = notification.userInfo!
        
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height;
        self.scrollView.contentInset = contentInset
        
        /*UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.bottomConstraint.constant += keyboardFrame.size.height + 20
        })*/
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
        
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("ToolbarNextPreviousVC") as! ToolbarNextPreviousVC
        controller.delegate = self
        self.toolBarNextPreviousItems = controller.toolbarNextPrevious;
        
        /*let subViews = self.scrollView.subviews
        for subview in subViews{
            subview.userInteractionEnabled = false;
        }*/
        
        self.imgProfile.layer.borderWidth = 5;
        self.imgProfile.layer.borderColor = UIColor.whiteColor().CGColor;
        self.imgProfile.layer.cornerRadius = 25.0;
        self.imgProfile.clipsToBounds = true;
        
        /*let rightNavigationItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: "rightItemTapped:")*/
        
        let saveNavigationItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: "saveItemTapped:")
        
        self.navigationItem.rightBarButtonItems = [saveNavigationItem] as [UIBarButtonItem];
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
        if userType == UserMode.UserModeEdit {
            self.configureValues()
        }
    }
}
