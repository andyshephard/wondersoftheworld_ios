//
//  WOWDetailHeaderFooterView.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 18/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWDetailHeaderFooterView: UITableViewHeaderFooterView {

	@IBOutlet weak var contentImageView: UIImageView!
	@IBOutlet weak var contentLabel: UILabel!
	
	class func classNib() -> UINib {
		return UINib(nibName: self.classReuseIdentifier(), bundle: nil)
	}
	
	class func classReuseIdentifier() -> String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
	
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
