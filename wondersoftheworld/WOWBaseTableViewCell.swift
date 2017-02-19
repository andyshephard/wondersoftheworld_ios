//
//  WOWBaseTableViewCell.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 14/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWBaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

	class func classNib() -> UINib {
		return UINib(nibName: self.classReuseIdentifier(), bundle: nil)
	}
	
	class func classReuseIdentifier() -> String {
		return NSStringFromClass(self).components(separatedBy: ".").last!
	}
}
