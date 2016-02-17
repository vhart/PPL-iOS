//
//  OrderedDictionary.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/17/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import Foundation

public struct OrderedDictionary<Tk: Hashable,Tv> {
    public var keys = [Tk]()
    public var values = [Tk:Tv]()
    
    public var description: String {
        var result = "{\n"
        for i in 0..<self.keys.count {
            let key = self.keys[i]
            result += "[\(i): \(key) => \(self[key])\n"
        }
        result += "}"
        return result
    }
    
    public init() {
        
    }
    
    public subscript(key: Tk) -> Tv? {
        get {
            return self.values[key]
        }
        set(newValue) {
            if newValue == nil {
                self.values.removeValueForKey(key)
                self.keys.filter { $0 != key }
                return
            }
            
            let oldValue = self.values.updateValue(newValue!, forKey: key)
            if oldValue == nil {
                self.keys.append(key)
            }
        }
    }

}