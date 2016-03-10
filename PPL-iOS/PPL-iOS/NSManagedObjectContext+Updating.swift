//
//  NSManagedObjectContext+Updating.swift
//  PPL-iOS
//
//  Created by Varindra Hart on 3/9/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation
import CoreData

extension NSManagedObjectContext {

    func saveContext() {
        do {
            try self.save()
        } catch {
            fatalError("\(error)")
        }
    }

}
