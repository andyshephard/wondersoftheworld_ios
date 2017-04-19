//
//  WOWBaseTableViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 13/04/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

class WOWBaseTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

		navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
