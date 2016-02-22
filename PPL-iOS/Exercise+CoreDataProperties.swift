//
//  Exercise+CoreDataProperties.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Exercise {

    @NSManaged var exerciseName: String
    @NSManaged var weight: Double
    @NSManaged var didCompleteAllSets: Bool
    @NSManaged var progressionSchemeRaw: NSNumber
    @NSManaged var numberOfSets: NSOrderedSet

}
