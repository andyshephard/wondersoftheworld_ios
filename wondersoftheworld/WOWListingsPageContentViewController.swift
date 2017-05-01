//
//  WOWListingsPageContentViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 14/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit
import QuartzCore

protocol WOWListingsPageContentViewControllerDelegate: class {
	func didTapPageContentViewControllerWithTag(tag: Int)
	func didSwipeNextPage()
	func didSwipePreviousPage()
}

class WOWListingsPageContentViewController: WOWBaseViewController {

	weak var delegate:WOWListingsPageContentViewControllerDelegate?
	
	public var tag: Int?
	
	@IBOutlet weak var contentImageView: UIImageView!
	@IBOutlet weak var gradientView: UIView!
	@IBOutlet weak var contentTitleLabel: UILabel!
	@IBOutlet weak var contentSubtitleLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

		contentImageView.clipsToBounds = true
		contentTitleLabel.adjustsFontSizeToFitWidth = true
		
		let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapPageContentView))
		
		self.view.addGestureRecognizer(tapGesture)
		
		let swipeGestureLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(didSwipeContentView))
		swipeGestureLeft.direction = UISwipeGestureRecognizerDirection.left
		self.view.addGestureRecognizer(swipeGestureLeft)
		
		let swipeGestureRight = UISwipeGestureRecognizer.init(target: self, action: #selector(didSwipeContentView))
		swipeGestureRight.direction = UISwipeGestureRecognizerDirection.right
		self.view.addGestureRecognizer(swipeGestureRight)
		
        // Do any additional setup after loading the view.
    }
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		applyGradient()
	}
	
	func applyGradient() {
		let gradient: CAGradientLayer = CAGradientLayer.init()
		gradient.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: gradientView.frame.size.height)
		gradient.colors = [UIColor.clear.cgColor, UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.9).cgColor]
		gradientView.layer.insertSublayer(gradient, at: 0)
	}
	
	func didTapPageContentView() {
		delegate?.didTapPageContentViewControllerWithTag(tag: tag!)
	}
	
	func didSwipeContentView(gesture: UISwipeGestureRecognizer) {
		switch gesture.direction {
		case UISwipeGestureRecognizerDirection.left:
			delegate?.didSwipeNextPage()
			break
			
		case UISwipeGestureRecognizerDirection.right:
			delegate?.didSwipePreviousPage()
			break
			
		default:
			print("unknown swipe direction - ignoring")
			break
		}
	}
}
