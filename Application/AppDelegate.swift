//
//  AppDelegate.swift
//  WikiRandom-2.0
//
//  Created by Clarke Kent on 1/7/23.
//
// brew install cocoapods

import UIKit
import FirebaseCore
import Firebase
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initializing Firebase :
        FirebaseApp.configure()
        // IQKeyboard
        IQKeyboardManager.shared.enable = true
        // Override point for customization after application launch.
        window = UIWindow()
        let vc = ViewController()
        let navView = UINavigationController(rootViewController: vc)
        window?.rootViewController = navView
        window?.makeKeyAndVisible() // Makes the window declaration the top level view
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}










