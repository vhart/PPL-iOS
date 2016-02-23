//
//  AppDelegate.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var coreDataStack = CoreDataStack()
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let tabBarController = self.window?.rootViewController as! UITabBarController
        let tabBarRootViewControllers = tabBarController.viewControllers! as [UIViewController]
        let navigationViewController = tabBarRootViewControllers.first as! UINavigationController
        let workoutCollectionViewController = navigationViewController.topViewController as! WorkoutCollectionViewController

        

        do {
            
            // Fetch workout logs
            let request = NSFetchRequest(entityName: "WorkoutLog")
        
            let workoutLogs = try coreDataStack.context.executeFetchRequest(request) as! [WorkoutLog]
            print(workoutLogs.count)
            //Create log manager singleton. Append fetched workoutLogs and managed object context
            LogManager.sharedInstance.setProperties(workoutLogs)
            let currentWorkoutLog = LogManager.sharedInstance.createWorkoutLog(coreDataStack.context)
            print(currentWorkoutLog.workout.typeOfWorkout)
            workoutCollectionViewController.currentWorkoutLog = currentWorkoutLog
            

            
        } catch let error as NSError {
            print("Fetching error: \(error.localizedDescription)")
        }
        
        workoutCollectionViewController.managedContext = coreDataStack.context
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        coreDataStack.saveContext()
        
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }
    
}

