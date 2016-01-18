//
//  MapViewController.swift
//  WorldTrotter
//
//  Created by lynn on 16/1/16.
//  Copyright © 2016年 green. All rights reserved.
//

import MapKit
import UIKit

class MapViewController: UIViewController {
    
    var mapView: MKMapView!
    
    override func loadView() {
        mapView = MKMapView()
        
        view = mapView
        
//        let segmentedControl = UISegmentedControl(items: ["Standard", "Hybrid", "Satallite"])
//        let standardStr = NSLocalizedString("Standard", comment: "Standard map view")
        let standardString = NSLocalizedString("Standard", comment: "Standard map view")
        let satelliteString
        = NSLocalizedString("Satellite", comment: "Satellite map view")
        let hybridString = NSLocalizedString("Hybrid", comment: "Hybrid map view")
        let segmentedControl
        = UISegmentedControl(items: [standardString, satelliteString, hybridString])
        
        segmentedControl.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.addTarget(self, action: "mapTypeChanged:", forControlEvents: .ValueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        
        let margin = view.layoutMarginsGuide
        let topConstraint = segmentedControl.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor, constant: 8)
        let leadingConstaint = segmentedControl.leadingAnchor.constraintEqualToAnchor(margin.leadingAnchor)
        let trailingConstraint = segmentedControl.trailingAnchor.constraintEqualToAnchor(margin.trailingAnchor)
        
        topConstraint.active = true
        leadingConstaint.active = true
        trailingConstraint.active = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("mapviewcontroller is loaded...")
        
        
    }
    
    func mapTypeChanged(segControl: UISegmentedControl){
        switch segControl.selectedSegmentIndex{
        case 0:
            mapView.mapType = .Standard
        case 1:
            mapView.mapType = .Hybrid
        case 2:
            mapView.mapType = .Satellite
        default:
            break
        }
    }
}
