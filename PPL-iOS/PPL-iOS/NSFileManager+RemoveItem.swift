//
//  NSFileManager+RemoveItem.swift
//  PPL-iOS
//
//  Created by Varindra Hart on 3/9/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

extension NSFileManager {

    func removeUrlIfPossible(url: NSURL) {
        if self.fileExistsAtPath(url.absoluteString) {
            do {
                try self.removeItemAtURL(url)
            }
            catch {
                print("path doesn't exist")
            }
        }
    }

}