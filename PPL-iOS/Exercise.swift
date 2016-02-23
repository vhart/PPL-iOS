//
//  Exercise.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData


class Exercise: NSManagedObject {
    
    // Insert code here to add functionality to your managed object subclass
    
    convenience init(nameOfExercise: String, weightOfExercise: Double, numberOfSets: Int16, numberOfReps: Int16, progressionScheme: ProgressionScheme, context: NSManagedObjectContext)
    {
        let entity = NSEntityDescription.entityForName("Exercise", inManagedObjectContext: context)
        
        self.init(entity: entity!, insertIntoManagedObjectContext: context)
        
        exerciseName = nameOfExercise
        weight = weightOfExercise
        didCompleteAllSets = false
        
        let mutableNumberOfSets = self.numberOfSets.mutableCopy() as! NSMutableOrderedSet
        
        for _ in 1...numberOfSets {
            let setTemp = Set(reps: numberOfReps, context: context)
            mutableNumberOfSets.addObject(setTemp)
        }
        
        self.numberOfSets = mutableNumberOfSets
        
        self.progressionScheme = progressionScheme
    }
    
    func progressWeight()
    {
        checkForCompletionOfSets()
        
        if didCompleteAllSets {
            calculateProgression()
        }
    }
    
    func resetExerciseSetCompletion()
    {
        didCompleteAllSets = false
    }
}

extension Exercise {
    func checkForCompletionOfSets()
    {
        didCompleteAllSets = numberOfCompletedSets(numberOfSets) == Int16(numberOfSets.count)
    }
    
    func numberOfCompletedSets(numberOfSets: NSOrderedSet) -> Int16
    {
        var completionCount: Int16 = 0
        
        for set in numberOfSets {
            let set = set as! Set
            
            if set.didCompleteSet {
                completionCount += 1
            }
        }
        
        return completionCount
    }
    
    func calculateProgression()
    {
        switch progressionScheme {
        case .UpperBody:
            weight += 5.0
        case .LowerBody:
            weight += 5.0
        case .Deadlift:
            weight += 10.0
        case .Accessory:
            weight += 2.5
        }
    }
}

extension Exercise {
    func abbreviatedExerciseName() -> String {
        
        switch exerciseName {
        case ExerciseName.deadlift:
            return "Deadlift"
        case ExerciseName.barbellRow:
            return "BB Row"
        case ExerciseName.pulldown:
            return "Pulldown"
        case ExerciseName.seatedCableRow:
            return "Cable Row"
        case ExerciseName.facePull:
            return "Face Pull"
        case ExerciseName.hammerCurl:
            return "HMR Curls"
        case ExerciseName.dumbbellCurl:
            return "DB Curls"
        case ExerciseName.benchPress:
            return "Bench"
        case ExerciseName.overheadPress:
            return "OH Press"
        case ExerciseName.inclineDumbbellPress:
            return "Incline DB"
        case ExerciseName.tricepsPushdown:
            return "Pushdown"
        case ExerciseName.lateralRaises1:
            return "Lat Raises"
        case ExerciseName.overheadTricepsExtension:
            return "OH Ext."
        case ExerciseName.lateralRaises2:
            return "Lat Raises"
        case ExerciseName.squat:
            return "Squat"
        case ExerciseName.romanianDeadlift:
            return "RDL"
        case ExerciseName.legPress:
            return "Leg Press"
        case ExerciseName.legCurl:
            return "Leg Curl"
        case ExerciseName.calfRaises:
            return "Calf Raises"
        default:
            return "None"
        }
        
    }
}

