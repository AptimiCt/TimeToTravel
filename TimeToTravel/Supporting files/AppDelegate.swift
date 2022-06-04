//
//  AppDelegate.swift
//  TimeToTravel
//
//  Created by Александр Востриков on 31.05.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let flightViewController = FlightViewController()
        let navigationFlightViewController = UINavigationController(rootViewController: flightViewController)
        if #available(iOS 15.0, *) {
            let appearanceNavigationBar = UINavigationBarAppearance()
            appearanceNavigationBar.backgroundColor = UIColor(named: Constants.accentColor)
            navigationFlightViewController.navigationBar.standardAppearance = appearanceNavigationBar
        }
        window?.rootViewController = navigationFlightViewController
        window?.makeKeyAndVisible()
        return true
    }


}

