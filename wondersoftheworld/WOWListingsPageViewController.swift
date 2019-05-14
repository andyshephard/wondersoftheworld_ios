//
//  WOWListingsPageViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 14/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWListingsPageViewController: UIPageViewController, WOWListingsPageContentViewControllerDelegate {

	weak var pageDelegate: WOWListingsPageViewControllerDelegate?
	
	// Public accessor.
	public var selectedCategory: WOWCategory?
	
	// Internal variables.
	var wonders: Array<WOWWonder> = []
	var pages: Array<WOWListingsPageContentViewController> = []
	
	var currentIndex: Int?
	
	//MARK: Loading
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		
		// Populate the |wonders| array.
		populateWonders()
		
		// And create the PageViewControllers based on these.
		setupPages()
		
		// Setup the initial view controller.
		if let initialViewController = pages.first {
			scrollToViewController(viewController: initialViewController)
		}
		
		// Notify the delegate of the number of views to scroll through.
		pageDelegate?.pageViewController(pageViewController: self, didUpdatePageCount: pages.count)
    }
	
	func populateWonders() {
		wonders = WOWDataModel.sharedModel.wondersForCategory(category: selectedCategory!)
	}
	
	func setupPages() {
		for index in 0...wonders.count-1 {
			
			let entry: WOWWonder = wonders[index]
			
			let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WOWListingsPageContentViewController") as! WOWListingsPageContentViewController
			_ = vc.view
			
			vc.tag = index
			vc.delegate = self
			vc.contentTitleLabel.text = entry.title
			vc.contentImageView.image = UIImage.init(named: entry.pageImage!)
			vc.contentSubtitleLabel.text = entry.desc
			pages.append(vc)
		}
	}
	
	/**
	Scrolls to the next vc.
	*/
	func scrollToNextViewController() {
		if let visibleViewController = viewControllers?.first,
			let nextViewController = pageViewController(self, viewControllerAfter: visibleViewController as! WOWListingsPageContentViewController) {
			scrollToViewController(viewController: nextViewController)
		}
	}
	
	func scrollToViewController(index newIndex: Int) {
		if let firstViewController = viewControllers?.first,
            let currentIndex = pages.firstIndex(of: firstViewController as! WOWListingsPageContentViewController) {
            let direction: UIPageViewController.NavigationDirection = newIndex >= currentIndex ? .forward : .reverse
			let nextViewController = pages[newIndex]
			scrollToViewController(viewController: nextViewController, direction: direction)
		}
	}
	
    private func scrollToViewController(viewController: UIViewController, direction: UIPageViewController.NavigationDirection = .forward) {
		setViewControllers([viewController], direction: direction, animated: true) { (finished) in
			self.notifyContainerDelegateOfNewIndex()
		}
	}
	
	//MARK: WOWListingsPageContentViewControllerDelegate
	func didTapPageContentViewControllerWithTag(tag: Int) {
		pageDelegate?.pageViewController(pageViewController: self, didSelectWonder: wonders[tag])
	}
	
	func didSwipePreviousPage() {
		let newIndex = currentIndex! - 1
		
		// Ensure that we won't scroll to non-existing location and crash.
		guard newIndex >= 0 else {
			return
		}
		
		// Scroll to previous index.
		scrollToViewController(index: newIndex)
	}
	
	func didSwipeNextPage() {
		let newIndex = currentIndex! + 1
		
		// Ensure that we won't scroll to non-existing location and crash.
		guard newIndex <= pages.count - 1 else {
			return
		}
		
		// Scroll to next index.
		scrollToViewController(index: newIndex)
	}
	
	func notifyContainerDelegateOfNewIndex() {
		if let firstViewController = viewControllers?.first,
            let index = pages.firstIndex(of: firstViewController as! WOWListingsPageContentViewController) {
			
			// Update the current index.
			currentIndex = index
			
			// Then notify the pageDelegate.
			pageDelegate?.pageViewController(pageViewController: self, didUpdatePageIndex: index)
		}
	}

}

extension WOWListingsPageViewController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
		
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! WOWListingsPageContentViewController) else {
			return nil
		}
		
		let previousIndex = viewControllerIndex - 1
		
		guard previousIndex >= 0 else {
			return pages.last
		}
		
		guard pages.count > previousIndex else {
			return nil
		}
		
		return pages[previousIndex]
		
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		
        guard let viewControllerIndex = pages.firstIndex(of: viewController as! WOWListingsPageContentViewController) else {
			return nil
		}
		
		let nextIndex = viewControllerIndex + 1
		let orderedViewControllersCount = pages.count
		
		guard orderedViewControllersCount != nextIndex else {
			return pages.first
		}
		
		guard orderedViewControllersCount > nextIndex else {
			return nil
		}
		
		return pages[nextIndex]
	}
}

extension WOWListingsPageViewController: UIPageViewControllerDelegate {
	
	func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
		
		notifyContainerDelegateOfNewIndex()
	}
}

protocol WOWListingsPageViewControllerDelegate: class {
	
	func pageViewController(pageViewController: WOWListingsPageViewController, didUpdatePageCount count: Int)
	
	func pageViewController(pageViewController: WOWListingsPageViewController, didUpdatePageIndex index: Int)
	
	func pageViewController(pageViewController: WOWListingsPageViewController, didSelectWonder wonder: WOWWonder)
}
