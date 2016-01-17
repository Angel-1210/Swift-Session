//
//  AppDelegate.swift
//  Session
//
//  Created by Dharmesh  on 08/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //------------------------------------------------------
    
    //MARK: Custom Method
    
    func setupControllers() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        let tabbarController = storyBoard .instantiateViewControllerWithIdentifier("AppTabbarController") as! UITabBarController
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.whiteColor()], forState:.Selected)
        
        window?.rootViewController = tabbarController;
    }
    
    //------------------------------------------------------
    
    func setupLoginController() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        
        let loginVCNavigation = storyBoard .instantiateViewControllerWithIdentifier("LoginVCNavigation") as! UINavigationController
        window?.rootViewController = loginVCNavigation;
    }
    
    //------------------------------------------------------
    
    //MARK: Completion Handler Demo
    
    func callBackMethodName( parameter : String, withBlock:( result : String)->Void) {
        
        print("Inside Block")
        
        withBlock(result: "Pass Result")
    }
    
    //------------------------------------------------------
    
    //MARK: Application Life Cycle

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        SQLiteManager .singleton() .checkAndCreateDatabaseWithOverwrite(false)
        
        if false { //logged-In

            
        } else {//Sign Up
            
            self .setupLoginController()
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    //------------------------------------------------------
    
    //MARK: Singleton
    
    static func singleton() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
}

