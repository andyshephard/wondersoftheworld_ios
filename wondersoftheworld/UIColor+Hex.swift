//
//  UIColor+Hex.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 13/04/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import Foundation

extension UIColor {
	
	public convenience init(hex: UInt32) {
		let mask = 0x000000FF
		
		let r = Int(hex >> 16) & mask
		let g = Int(hex >> 8) & mask
		let b = Int(hex) & mask
		
		let red   = CGFloat(r) / 255
		let green = CGFloat(g) / 255
		let blue  = CGFloat(b) / 255
		
		self.init(red:red, green:green, blue:blue, alpha:1)
	}
	
	class func headerFooterColor() -> UIColor {
		return UIColor(hex: 0x4B3F72)
	}
	
	class func navigationBarColor() -> UIColor {
		return UIColor(hex: 0x726DA8)
	}
}
