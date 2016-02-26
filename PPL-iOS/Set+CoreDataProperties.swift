//
//  Set+CoreDataProperties.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/25/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Set {

    @NSManaged var didCompleteSet: Bool
    @NSManaged var numberOfReps: Int16
    @NSManaged var repsCompleted: Int16
    @NSManaged var setIndex: Int16
    @NSManaged var firstAttempt: Bool
    @NSManaged var exercise: Exercise

}
