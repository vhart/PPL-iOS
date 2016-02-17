//
//  Set.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/14/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

public class Set {
    let numberOfReps: Int
    var didComplete = false
    
    init(reps: Int){
        numberOfReps = reps
    }
    
    public func checkForCompletion(numberOfRepsCompleted: Int) {
        didComplete = numberOfRepsCompleted >= numberOfReps
    }
}