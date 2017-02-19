//
//  WOWListingsViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 14/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

let kSegueIdentifierPushToListingsPageVC = "pushToListingsDetailPageView"

class WOWListingsViewController: UITableViewController {

	var selectedCategory: WOWCategory?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
		
		// Set image as navigation bar title
		let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 44))
		imageView.contentMode = .scaleAspectFit
		let image = UIImage(named: "navBarView")
		imageView.image = image
		self.navigationItem.titleView = imageView
		
		// Setup tableView.
		self.tableView.register(WOWListingsTableViewCell.classNib(), forCellReuseIdentifier: WOWListingsTableViewCell.classReuseIdentifier())
	}
	
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return WOWDataModel.sharedModel.categories!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell: WOWListingsTableViewCell = tableView.dequeueReusableCell(withIdentifier: WOWListingsTableViewCell.classReuseIdentifier(), for: indexPath) as! WOWListingsTableViewCell

		let cat: WOWCategory = WOWDataModel.sharedModel.categories![indexPath.row]
		cell.cellImageView.image = UIImage.init(named: cat.image!)
		cell.cellLabel.text = cat.title!

        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
		
		selectedCategory = WOWDataModel.sharedModel.categories![indexPath.row]
		performSegue(withIdentifier: kSegueIdentifierPushToListingsPageVC, sender: self)
	}

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		let vc: WOWListingsContainerViewController = segue.destination as! WOWListingsContainerViewController
		vc.selectedCategory = selectedCategory
	}
}