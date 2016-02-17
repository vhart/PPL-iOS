//
//  Set.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/14/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

struct Set {
    let numberOfReps: Int
    var didComplete = false
    
    init(reps: Int){
        numberOfReps = reps
    }
    
    internal mutating func checkForCompletion(numberOfRepsCompleted: Int) {
        didComplete = numberOfRepsCompleted >= numberOfReps
    }
}