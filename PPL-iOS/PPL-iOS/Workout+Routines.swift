//
//  Workout+Routines.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData

//Create base routines
extension Workout {
    private func createBasePullRoutine(context: NSManagedObjectContext) {
        let mutableSetOfExercies = self.exercises.mutableCopy() as! NSMutableOrderedSet
        
        let pulldown = Exercise(nameOfExercise: ExerciseName.pulldown, weightOfExercise: 85.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(pulldown)
        
        let seatedCableRow = Exercise(nameOfExercise: ExerciseName.seatedCableRow, weightOfExercise: 85.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(seatedCableRow)
        
        let facePull = Exercise(nameOfExercise: ExerciseName.facePull, weightOfExercise: 40.0, numberOfSets: 5, numberOfReps: 20, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(facePull)
        
        let hammerCurl = Exercise(nameOfExercise: ExerciseName.hammerCurl, weightOfExercise: 25.0, numberOfSets: 4, numberOfReps: 12, progressionScheme: .Accessory, context: context)
        mutableSetOfExercies.addObject(hammerCurl)
        
        let dumbbellCurl = Exercise(nameOfExercise: ExerciseName.dumbbellCurl, weightOfExercise: 25.0, numberOfSets: 4, numberOfReps: 12, progressionScheme: .Accessory, context: context)
        mutableSetOfExercies.addObject(dumbbellCurl)
        
        self.exercises = mutableSetOfExercies
        
    }
    
    private func createBasePushRoutine(context: NSManagedObjectContext) {
        let mutableSetOfExercies = self.exercises.mutableCopy() as! NSMutableOrderedSet
        
        let inclineDumbbellPress = Exercise(nameOfExercise: ExerciseName.inclineDumbbellPress, weightOfExercise: 35.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .Accessory, context: context)
        mutableSetOfExercies.addObject(inclineDumbbellPress)
        
        let tricepsPushDown = Exercise(nameOfExercise: ExerciseName.tricepsPushdown, weightOfExercise: 65.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(tricepsPushDown)
        
        let lateralRaises1 = Exercise(nameOfExercise: ExerciseName.lateralRaises1, weightOfExercise: 15.0, numberOfSets: 3, numberOfReps: 20, progressionScheme: .Accessory, context: context)
        mutableSetOfExercies.addObject(lateralRaises1)
        
        let overheadTricepsExtensions = Exercise(nameOfExercise: ExerciseName.overheadTricepsExtension, weightOfExercise: 65.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(overheadTricepsExtensions)
        
        let lateralRaises2 = Exercise(nameOfExercise: ExerciseName.lateralRaises2, weightOfExercise: 15.0, numberOfSets: 3, numberOfReps: 20, progressionScheme: .Accessory, context: context)
        mutableSetOfExercies.addObject(lateralRaises2)
        
        self.exercises = mutableSetOfExercies
    }
    
}

//Creates Different Types of Routines
extension Workout {
    func createPullRoutine(context: NSManagedObjectContext) {
        let mutableSetOfExercies = self.exercises.mutableCopy() as! NSMutableOrderedSet
        
        let deadlift = Exercise(nameOfExercise: ExerciseName.deadlift, weightOfExercise: 135.0, numberOfSets: 1, numberOfReps: 5, progressionScheme: .Deadlift, context: context)
        mutableSetOfExercies.addObject(deadlift)
        
        createBasePullRoutine(context)
        
        let array = self.exercises.copyToArray() as! [Exercise]
        mutableSetOfExercies.addObjectsFromArray(array)
        
        self.exercises = mutableSetOfExercies
    }
    
    func createPushRoutine(context: NSManagedObjectContext) {
        let mutableSetOfExercies = self.exercises.mutableCopy() as! NSMutableOrderedSet
        
        let benchPress = Exercise(nameOfExercise: ExerciseName.benchPress, weightOfExercise: 135.0, numberOfSets: 5, numberOfReps: 5, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(benchPress)
        
        let overheadPress = Exercise(nameOfExercise: ExerciseName.overheadPress, weightOfExercise: 135.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(overheadPress)
        
        createBasePushRoutine(context)
        
        let array = self.exercises.copyToArray() as! [Exercise]
        mutableSetOfExercies.addObjectsFromArray(array)
        
        self.exercises = mutableSetOfExercies
    }
    
    func createLegRoutine(context: NSManagedObjectContext) {
        let mutableSetOfExercies = self.exercises.mutableCopy() as! NSMutableOrderedSet
        
        let squat = Exercise(nameOfExercise: ExerciseName.squat, weightOfExercise: 165.0, numberOfSets: 3, numberOfReps: 5, progressionScheme: .LowerBody, context: context)
        mutableSetOfExercies.addObject(squat)
        
        let romanianDeadlift = Exercise(nameOfExercise: ExerciseName.romanianDeadlift, weightOfExercise: 175.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .LowerBody, context: context)
        mutableSetOfExercies.addObject(romanianDeadlift)
        
        let legPress = Exercise(nameOfExercise: ExerciseName.legPress, weightOfExercise: 225.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .LowerBody, context: context)
        mutableSetOfExercies.addObject(legPress)
        
        let legCurl = Exercise(nameOfExercise: ExerciseName.legCurl, weightOfExercise: 225.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .LowerBody, context: context)
        mutableSetOfExercies.addObject(legCurl)
        
        let calfRaises = Exercise(nameOfExercise: ExerciseName.calfRaises, weightOfExercise: 180.0, numberOfSets: 5, numberOfReps: 20, progressionScheme: .LowerBody, context: context)
        mutableSetOfExercies.addObject(calfRaises)
        
        self.exercises = mutableSetOfExercies
    }
}

//Contains Alternate Routines
extension Workout {
    func createAlternatePullRoutine(context: NSManagedObjectContext) {
        let mutableSetOfExercies = self.exercises.mutableCopy() as! NSMutableOrderedSet
        
        let barbellRow = Exercise(nameOfExercise: ExerciseName.barbellRow, weightOfExercise: 135.0, numberOfSets: 5, numberOfReps: 5, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(barbellRow)
        
        createBasePullRoutine(context)
        
        let array = self.exercises.copyToArray() as! [Exercise]
        mutableSetOfExercies.addObjectsFromArray(array)
        
        self.exercises = mutableSetOfExercies
        
    }
    
    func createAlternatePushRoutine(context: NSManagedObjectContext) {
        let mutableSetOfExercies = self.exercises.mutableCopy() as! NSMutableOrderedSet
        
        let overheadPress = Exercise(nameOfExercise: ExerciseName.overheadPress, weightOfExercise: 135.0, numberOfSets: 5, numberOfReps: 5, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(overheadPress)
        
        let benchPress = Exercise(nameOfExercise: ExerciseName.benchPress, weightOfExercise: 135.0, numberOfSets: 3, numberOfReps: 12, progressionScheme: .UpperBody, context: context)
        mutableSetOfExercies.addObject(benchPress)
        
        createBasePushRoutine(context)
        
        let array = self.exercises.copyToArray() as! [Exercise]
        mutableSetOfExercies.addObjectsFromArray(array)
        
        self.exercises = mutableSetOfExercies
    }
}