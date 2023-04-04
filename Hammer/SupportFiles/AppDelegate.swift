//
//  AppDelegate.swift
//  Hammer
//
//  Created by Kuat Bodikov on 03.04.2023.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let tabBarConfigurator = TabBarConfigurator()
        window?.rootViewController = tabBarConfigurator.configure()
        
        return true
    }


}

