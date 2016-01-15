//
//  LocationManager.swift
//  Session
//
//  Created by Pankti  on 15/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager : NSObject, CLLocationManagerDelegate {
    
    static let sharedInstance = LocationManager()
    
    var locationManager : CLLocationManager!
    var currentLocation : CLLocation!
    
    //------------------------------------------------------
    
    //MARK: Custom Method
    
    func updateLocation() {
        locationManager .startUpdatingLocation()
    }
    
    //------------------------------------------------------
    
    func stopUpdatingLocations() {
        locationManager .stopUpdatingLocation()
    }
    
    //MARK: CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations[0]
    }
    
    func getCurrentLocation() -> CLLocation {
        return currentLocation
    }
    
    //------------------------------------------------------
    
    //MARK: Initialisation
    
    required override init() {
        super.init()
        
        /* info.plist
        NSLocationAlwaysUsageDescription
        NSLocationWhenInUseUsageDescription
        */
        
        self.locationManager = CLLocationManager()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.delegate = self;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    static func singleton () -> LocationManager {
        
        return sharedInstance;
    }
}
