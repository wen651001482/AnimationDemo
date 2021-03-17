//
//  AppDelegate.swift
//  01-CoreAnimation
//
//  Created by wenjie on 2021/3/16.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		window = UIWindow(frame: UIScreen.main.bounds)
		window?.backgroundColor = UIColor.white
		
		window?.rootViewController = UINavigationController(rootViewController: NewCGAnimationVC())
		window?.makeKeyAndVisible()
		
		return true
	}

}

