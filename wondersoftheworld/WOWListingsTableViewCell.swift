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
	@IBOutlet weak var cellSubtitleLabel: UILabel!
	@IBOutlet weak var gradientView: UIView!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
		cellLabel.adjustsFontSizeToFitWidth = true
    }
	
	public func applyGradient() {
		let gradient: CAGradientLayer = CAGradientLayer.init()
		gradient.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height)
		gradient.colors = [UIColor.init(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.4).cgColor, UIColor.clear.cgColor]
		gradientView.layer.insertSublayer(gradient, at: 0)
		
		setNeedsLayout()
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	
}
