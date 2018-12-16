//
//  AppDelegate.swift
//  Skyscanner
//
//  Created by Ricardo Casanova on 12/12/2018.
//  Copyright © 2018 Skyscanner. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    private var reachability: Reachability?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configureReachability()
        configureNavigationBar()
        showInitialView()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }

}

//MARK: - Navigation methods
extension AppDelegate  {
    
    private func showInitialView() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let mainTabBar = MainTabBar()
        
        self.window?.rootViewController = mainTabBar
        self.window?.makeKeyAndVisible()
    }
    
    private func configureNavigationBar() {
        UINavigationBar.appearance().barStyle = .default
        UINavigationBar.appearance().barTintColor = .white
    }
    
}

//MARK: - Reachability
extension AppDelegate {
    
    private func configureReachability() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkChange), name: NSNotification.Name.reachabilityChanged, object: nil)
        reachability = Reachability.forInternetConnection()
        reachability?.startNotifier()
    }
    
    @objc private func handleNetworkChange() {
        if !ReachabilityManager.shared.hasConnection() {
            showReachabilityMessage(true)
            return
        }
        
        showReachabilityMessage(false)
    }
    
    /**
     * Show reachability message
     *
     * - parameters:
     *      -show: show / hide reachability message
     */
    private func showReachabilityMessage(_ show: Bool) {
        guard let rootViewController = UIApplication.shared.windows[0].rootViewController else {
            return
        }
        
        if show, let _ = rootViewController.presentedViewController as? GeneralMessageViewController {
            return
        }
        
        if show {
            let generalMessageViewController = GeneralMessageViewController()
            generalMessageViewController.modalTransitionStyle = .coverVertical
            generalMessageViewController.modalPresentationStyle = .overCurrentContext
            generalMessageViewController.presenter = GeneralMessagePresenter(view: generalMessageViewController, type: .NoInternetConnection)
            rootViewController.present(generalMessageViewController, animated: true, completion: nil)
        } else {
            rootViewController.dismiss(animated: true, completion: nil)
        }
    }
    
}

