//
//  MapVC.swift
//  Session
//
//  Created by Pankti  on 15/01/16.
//  Copyright © 2016 Dharmesh. All rights reserved.
//

import UIKit
import Foundation
import MapKit
import CoreLocation

class MapVC: UIViewController, MKMapViewDelegate, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var mapLocationView: MKMapView!
    @IBOutlet weak var locationSearchBar: UISearchBar!
    
    var arrayLocations = NSArray();
    var arrayLocationsResults = NSArray();
    
    var locationManager : CLLocationManager!
    
    //MARK: MKMapViewDelegate
    
    func mapView(mapView: MKMapView, didUpdateUserLocation userLocation: MKUserLocation) {
        
        //23.0300° N, 72.5800° E
        let center = userLocation.coordinate
        let span = MKCoordinateSpanMake(10, 10)
        
        self.mapLocationView .setRegion(MKCoordinateRegion(center: center, span: span), animated: true)
    }

    //------------------------------------------------------
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
    
        if annotation is MKUserLocation {
            return nil
        }
        
        let identifier = "mapAnnotationView"
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
        
        if (annotationView == nil) {
           
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.image = UIImage.init(named: "IconLocationPin")
            annotationView?.canShowCallout = true;
        }
        
        return annotationView;
    }
    
    //MARK: UISearchBarDelegate 
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let searchString = searchBar.text?.stringByAppendingString(text)
        
        let predicate = NSPredicate(format: "self.LocationName CONTAINS[cd] %@", searchString!)
        let result = arrayLocations .filteredArrayUsingPredicate(predicate)
        arrayLocationsResults = result;
        
        return true;
    }
    
    //MARK: UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLocationsResults.count;
    }

    //------------------------------------------------------
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "SearchCell"

        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }
        
        let values = arrayLocationsResults.objectAtIndex(indexPath.row) as! NSDictionary
        cell?.textLabel?.text = values.objectForKey(kLocationName) as? String
        
        return cell!;
    }
    
    //MARK: UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
       
        tableView .deselectRowAtIndexPath(indexPath, animated: true);

        self.searchDisplayController!.setActive(false, animated: true)
        
        self.mapLocationView .removeAnnotations(self.mapLocationView .annotations)
        
        let values = arrayLocationsResults.objectAtIndex(indexPath.row) as! NSDictionary
        
        let lattitude = values.objectForKey(kLattitude) as! CLLocationDegrees
        let longitude = values.objectForKey(kLongitude) as! CLLocationDegrees
        let locationName = values.objectForKey(kLocationName) as! String
        
        let ahmedabadAnnotation = MapAnnotation(coordinate: CLLocationCoordinate2DMake( lattitude, longitude), title: locationName, subtitle: "Comming soon!")
        
        self.mapLocationView .addAnnotation(ahmedabadAnnotation)
        
    }
    
    //------------------------------------------------------
    
    //MARK: UIView Life Cycle Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapLocationView .showsUserLocation = true
        self.mapLocationView .showsBuildings = true
        self.mapLocationView .showsPointsOfInterest = true
        
        if #available(iOS 9.0, *) {
            
            self.mapLocationView.showsCompass = true
            self.mapLocationView.showsScale = true
            self.mapLocationView .showsTraffic = true
        }
        self.mapLocationView.delegate = self
        
        //LocationManager.singleton().stopUpdatingLocations()
        /*let ahmedabadAnnotation = MapAnnotation(coordinate: CLLocationCoordinate2DMake(23.0300, 72.5800), title: "Ahmedabad", subtitle: "CG Road")
        self.mapLocationView .addAnnotation(ahmedabadAnnotation)*/
        
        //Location list
        arrayLocations = [ [kLocationName : "Ahmedabad", kLattitude : 23.0300, kLongitude : 72.5800], [kLocationName : "Baroda", kLattitude : 22.3000, kLongitude : 73.2000], [kLocationName : "Surat", kLattitude : 21.1700, kLongitude : 72.8300], [kLocationName : "Rajkot", kLattitude : 22.3000, kLongitude : 70.7833] ]

    }
    
    //------------------------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}