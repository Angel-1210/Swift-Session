//
//  Validation.swift
//  Session
//
//  Created by Dharmesh  on 08/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import Foundation

class Validation {
    
    static func isValidName( string : String) -> Bool {
       
        let regExp = "[A-Z][a-z]*"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
        let isValid = predicate .evaluateWithObject(string)
        return isValid;

    }
    
    static func isValidShortName( string : NSString) -> Bool {
       
        let regExp = "[A-Z][.]?"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regExp)
        let isValid = predicate .evaluateWithObject(string)
        return isValid;
    }
    
}