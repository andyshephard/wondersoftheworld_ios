//
//  WOWListingsContainerViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 17/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit
import QuartzCore

let kSegueIdentifierPushToDetailView = "pushToWOWDetailView"

class WOWListingsContainerViewController: WOWBaseViewController {

	// Public accessor.
	public var selectedCategory: WOWCategory?
	
	var selectedWonder: WOWWonder?
	
	@IBOutlet weak var containerView: UIView!
	@IBOutlet weak var pageControl: UIPageControl!
	
	var listingsPageViewController: WOWListingsPageViewController?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
//		title = selectedCategory?.title
		
		let titleLabel: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: (navigationController?.view.bounds.size.width)! - 144.0, height: 44))
		titleLabel.text = selectedCategory?.title
		titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
		titleLabel.backgroundColor = UIColor.clear
		titleLabel.textColor = UIColor.white
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.minimumScaleFactor = 0.5
		titleLabel.textAlignment = .center
		navigationItem.titleView = titleLabel
		
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        pageControl.addTarget(self, action: #selector(WOWListingsContainerViewController.didChangePageControlValue), for: .valueChanged)
    }

    @objc func didChangePageControlValue() {
		listingsPageViewController?.scrollToViewController(index: pageControl.currentPage)
	}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == kSegueIdentifierPushToDetailView {
			let detailVC: WOWDetailViewController = segue.destination as! WOWDetailViewController
			detailVC.wonder = selectedWonder
			
		} else {
			if let listingsPageViewController = segue.destination as? WOWListingsPageViewController {
				self.listingsPageViewController = listingsPageViewController
				self.listingsPageViewController?.pageDelegate = self
				self.listingsPageViewController?.selectedCategory = selectedCategory
			}
		}
    }
}

extension WOWListingsContainerViewController: WOWListingsPageViewControllerDelegate {
	
	func pageViewController(pageViewController: WOWListingsPageViewController, didUpdatePageCount count: Int) {
		pageControl.numberOfPages = count
	}
	
	func pageViewController(pageViewController: WOWListingsPageViewController, didUpdatePageIndex index: Int) {
		pageControl.currentPage = index
	}
	
	func pageViewController(pageViewController: WOWListingsPageViewController, didSelectWonder wonder: WOWWonder) {
		selectedWonder = wonder
		self.performSegue(withIdentifier: kSegueIdentifierPushToDetailView, sender: self)
	}
	
}
