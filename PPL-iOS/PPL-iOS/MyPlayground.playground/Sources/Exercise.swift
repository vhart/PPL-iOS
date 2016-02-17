//
//  Exercise.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/14/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

public class Exercise {
    let name: String
    var weight: Double
    public var sets = [Set]()
    var didCompleteAllSets: Bool
    let progressionScheme: ProgressionScheme
    
    public init(nameOfExercise: String, weightOfExercise: Double, numberOfSets: Int, numberOfReps: Int, progressionScheme: ProgressionScheme) {
        name = nameOfExercise
        weight = weightOfExercise
        didCompleteAllSets = false
        
        for _ in 1...numberOfSets {
            let setTemp = Set(reps: numberOfReps)
            sets.append(setTemp)
        }
        
        self.progressionScheme = progressionScheme
    }
    
    func progressWeight() {
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
    
    public func checkForCompletionOfSets() {
        var completionCount = 0
        for set in sets {
            if set.didComplete == true {
                completionCount += 1
            }
        }
        
        didCompleteAllSets = completionCount == sets.count
        
        if didCompleteAllSets {
            progressWeight()
        }
    }
}