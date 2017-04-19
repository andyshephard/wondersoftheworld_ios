//
//  WOWDataModel.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 19/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWDataModel: NSObject {

	var categories: Array<WOWCategory>?
	var wonders: Array<WOWWonder>?
	
	static let sharedModel = WOWDataModel()
	
	func populateData() {
		
		// Load the JSON data.
		let filePath = Bundle.main.path(forResource: "data", ofType: "json")
		var jsonString: String?
		var jsonResponse: Dictionary<String, Any>?
		
		do {
			jsonString = try String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
		} catch {
			print(error.localizedDescription)
		}
		
		let data = jsonString!.data(using: .utf8)
		
		do {
			jsonResponse = try JSONSerialization.jsonObject(with: data!, options:[]) as? [String: Any]
		} catch {
			print(error.localizedDescription)
		}
		
		// Parse the JSON data.
		let categoryList: [Dictionary<String, Any>] = jsonResponse!["categories"] as! [Dictionary<String, Any>]
		
		categories = WOWCategory.createCategoriesWithData(categoryArray: categoryList)
		
		let wonderList: [Dictionary<String, Any>] = jsonResponse!["wonders"] as! [Dictionary<String, Any>]
		
		wonders = WOWWonder.createWondersWithData(wonderArray: wonderList)
		
	}
	
	func categoryWithName(name: String) -> WOWCategory {
		
		var returnedCat: WOWCategory?
		
		for category: WOWCategory in categories! {
			if category.title == name {
				returnedCat = category
				break
			}
		}
		
		return returnedCat!
	}
	
	func wondersForCategory(category: WOWCategory) -> [WOWWonder] {
		
		var returnedWonders: [WOWWonder] = []
		
		for wonder: WOWWonder in wonders! {
			
			if (wonder.categories?.contains(category))! {
				returnedWonders.append(wonder)
			}
		}
		
		return returnedWonders
	}
	
	func wonderWithName(name: String) -> WOWWonder {
		
		var returnedWonder: WOWWonder?
		
		for wonder: WOWWonder in wonders! {
			if (wonder.title == name) {
				returnedWonder = wonder
				break
			}
		}
		
		return returnedWonder!
	}
}
