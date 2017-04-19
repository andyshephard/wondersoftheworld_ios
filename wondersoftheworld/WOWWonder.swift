//
//  WOWWonder.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 19/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWWonder: NSObject {
	
	var categories: Array<WOWCategory>?
	var constructed: String?
	var desc: String?
	var fullImage: String?
	var isManMade: Bool?
	var isVR: Bool?
	var location: String?
	var latitude: Double?
	var longitude: Double?
	var pageImage: String?
	var popularity: String?
	var title: String?
	var vrMode: String?
	
	init(wonderData: Dictionary <String, Any>) {
		
		let cats: [String] = wonderData["categories"] as! [String]
		var catArray: Array<WOWCategory> = []
		
		for cat in cats {
			catArray.append(WOWDataModel.sharedModel.categoryWithName(name: cat))
		}
		
		self.categories = catArray
		self.constructed = wonderData["constructed"] as? String
		self.desc = wonderData["description"] as? String
		self.fullImage = wonderData["fullImage"] as? String
		self.isManMade = wonderData["isManMade"] as? Bool
		self.isVR = wonderData["isVR"] as? Bool
		self.location = wonderData["location"] as? String
		self.latitude = wonderData["latitude"] as? Double
		self.longitude = wonderData["longitude"] as? Double
		self.pageImage = wonderData["pageImage"] as? String
		self.popularity = wonderData["popularity"] as? String
		self.title = wonderData["title"] as? String
		self.vrMode = wonderData["vrMode"] as? String
	}
	
	class func createWonderWithData(data: Dictionary <String, Any>) -> WOWWonder {
		let wonder = WOWWonder.init(wonderData: data)
		return wonder
	}
	
	class func createWondersWithData(wonderArray: [Dictionary <String, Any>]) -> Array<WOWWonder> {
		
		var wondersArray: Array<WOWWonder> = []
		for entry in wonderArray {
			wondersArray.append(createWonderWithData(data: entry))
		}
		
		return wondersArray
	}
}
