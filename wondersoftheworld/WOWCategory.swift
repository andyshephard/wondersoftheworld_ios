//
//  WOWCategory.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 19/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWCategory: NSObject {
	var title: String?
	var image: String?
	var index: Int?
	
	init(categoryData: Dictionary <String, Any>) {
		self.title = categoryData["title"] as? String
		self.image = categoryData["image"] as? String
		self.index = categoryData["index"] as? Int
	}
	
	class func createCategoryWithData(categoryData: Dictionary <String, Any>) -> WOWCategory {
		
		let category = WOWCategory.init(categoryData: categoryData)
		return category
	}
	
	class func createCategoriesWithData(categoryArray: [Dictionary <String, Any>]) -> Array<WOWCategory> {
		
		var categoriesArray: Array<WOWCategory> = []
		
		for entry in categoryArray {
			categoriesArray.append(createCategoryWithData(categoryData: entry))
		}
		
		return categoriesArray
	}
}
