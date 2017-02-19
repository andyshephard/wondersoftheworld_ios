//
//  WOWListingsTableViewCell.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 14/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWListingsTableViewCell: WOWBaseTableViewCell {

	@IBOutlet weak var cellImageView: UIImageView!
	@IBOutlet weak var cellMaskView: UIView!
	@IBOutlet weak var cellLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		cellLabel.adjustsFontSizeToFitWidth = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	
}
