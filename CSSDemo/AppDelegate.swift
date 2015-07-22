//
//  AppDelegate.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 15.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.setupAppearance()
        
        
        let splitViewController = self.window!.rootViewController as! UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as! UINavigationController
        navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
    }

    func applicationDidEnterBackground(application: UIApplication) {
    }

    func applicationWillEnterForeground(application: UIApplication) {
    }

    func applicationDidBecomeActive(application: UIApplication) {
    }

    func applicationWillTerminate(application: UIApplication) {
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? MediaDetailViewController {
                if topAsDetailController.media == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }
    
    // MARK: - Appearance 
    
    func setupAppearance() {
        // navigation bar 
        let navbarAppearance = UINavigationBar.appearance()
        navbarAppearance.tintColor = UIColor(red: 115 / 255.0, green: 162 / 255.0, blue: 177 / 255.0, alpha: 1.0)
        navbarAppearance.titleTextAttributes = [
            NSFontAttributeName : UIFont(name: "BloggerSans-Medium", size: 22)!,
            NSForegroundColorAttributeName : UIColor(white: 96 / 255.0, alpha: 1.0),
        ]
        
        // navigation bar item
        let navbarItemAppearance = UIBarButtonItem.appearance()
        let attributes = [
            NSFontAttributeName : UIFont.demo_regularFont
        ]
        navbarItemAppearance.setTitleTextAttributes(attributes, forState: UIControlState.Normal)
        navbarItemAppearance.setTitleTextAttributes(attributes, forState: UIControlState.Highlighted)

    }

}

