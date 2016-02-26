//
//  Set.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData


class Set: NSManagedObject {

// Insert code here to add functionality to your managed object subclass
    
    convenience init(reps: Int16, context: NSManagedObjectContext)
    {
        let entity = NSEntityDescription.entityForName("Set", inManagedObjectContext: context)
        
        self.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        numberOfReps = reps
        repsCompleted = 0
        firstAttempt = true
        
        
    }
    
    func checkForCompletion(numberOfRepsCompleted: Int16) {
        didCompleteSet = numberOfRepsCompleted >= numberOfReps
    }
    
    func resetSetCompletion(){
        didCompleteSet = false
    }
}
