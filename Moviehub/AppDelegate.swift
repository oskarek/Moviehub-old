//
//  AppDelegate.swift
//  Moviehub
//
//  Created by Oskar Ek on 2017-02-06.
//  Copyright © 2017 Oskar Ek. All rights reserved.
//

import UIKit
import MoviehubFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  let window = UIWindow()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    self.window.rootViewController = MovieSearchViewController()
    self.window.backgroundColor = .white
    self.window.makeKeyAndVisible()
    return true
  }
}
