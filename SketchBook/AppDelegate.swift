//
//  AppDelegate.swift
//  SketchBook
//
//  Created by Cory Kim on 2019/11/16.
//  Copyright © 2019 corykim0829. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let homeViewController = HomeViewController(nibName: "HomeViewController", bundle: nil)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = homeViewController
        window?.makeKeyAndVisible()
        
        return true
    }
}

