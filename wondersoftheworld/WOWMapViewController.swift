//
//  WOWMapViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 12/04/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit
import CoreLocation
import Mapbox
import MapboxGeocoder

let kSeguePushToWOWDetailViewFromMap = "pushToWOWDetailViewFromMap"

class WOWMapViewController: WOWBaseViewController, MGLMapViewDelegate {

	var kMapboxAccessToken: String!
	var placemarks: [MGLPointAnnotation] = []
	
	var selectedWonder: WOWWonder?
	
	@IBOutlet weak var mapView: MGLMapView!
	var geocoder: Geocoder!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.title = "Map"
		
		setupMap()
		setupPlacemarks()
		
	}
	
	func setupMap() {
		
//		mapView.styleURL = NSURL(string: "mapbox://styles/mapbox/satellite-v9") as URL!
		
		let path = Bundle.main.path(forResource: "Info", ofType: "plist")
		let dict = NSDictionary(contentsOfFile: path!)
		kMapboxAccessToken = dict?.object(forKey: "MGLMapboxAccessToken") as! String!
		
		MGLAccountManager.setAccessToken(kMapboxAccessToken)
		
		mapView.delegate = self
		geocoder = Geocoder(accessToken: kMapboxAccessToken)
		
	}
	
	func setupPlacemarks() {
		
		var index: Int = 0
		
		for wonder:WOWWonder in WOWDataModel.sharedModel.wonders! {
			index = index + 1
			
			if (wonder.latitude != nil && wonder.longitude != nil) {
				let annotation: MGLPointAnnotation = MGLPointAnnotation()
				annotation.coordinate = CLLocationCoordinate2DMake(wonder.latitude!, wonder.longitude!)
				annotation.title = wonder.title
				annotation.subtitle = wonder.location
				placemarks.append(annotation)
			}
		}
		
		mapView.addAnnotations(placemarks)
	}
	
	func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
		let point: MGLPointAnnotation = annotation as! MGLPointAnnotation
		let title: String = point.title!
		selectedWonder = WOWDataModel.sharedModel.wonderWithName(name: title)
		self.performSegue(withIdentifier: kSeguePushToWOWDetailViewFromMap, sender: self)
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == kSeguePushToWOWDetailViewFromMap {
			let detailVC: WOWDetailViewController = segue.destination as! WOWDetailViewController
			detailVC.wonder = selectedWonder
			
		}
	}
}
