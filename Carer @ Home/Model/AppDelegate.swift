//
//  AppDelegate.swift
//  Carer @ Home
//
//  Created by Wayne Bruton on 2017/11/28.
//  Copyright © 2017 Wayne Bruton. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Did Enter Background") //info.plist APPlicationDoesNotRunInBackground = Yes
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
       print("We have Terminated") //info.plist APPlicationDoesNotRunInBackground = Yes
    }


}

