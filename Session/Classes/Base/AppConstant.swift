//
//  AppConstant.swift
//  Session
//
//  Created by Dharmesh  on 08/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import Foundation

class AppConstant {
    
    //static let kFirstName = "FirstName"
}

// Or

let kFirstName      = "FirstName"
let kLastName       = "LastName"
let kShortName      = "ShortName"
let kBornOn         = "BornOn"
let kJoiningAt      = "JoiningAt"
let kReleventExp    = "ReleventExp"

let kLocationName   = "LocationName"
let kLattitude      = "Lattitude"
let kLongitude      = "Longitude"

enum UserMode {
    
    case UserModeAdd
    case UserModeEdit
}

func isEmptyString( string : String) -> Bool {
    
    let resultString = string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    
    guard (resultString.isEmpty) else {
        return false;
    }
    return true;
}