//
//  WOWDetailViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 12/02/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit

struct kDetailTableViewHeaderSection {
	var value: UInt32
	init(_ val: UInt32) { value = val }
}
let kDetailTableViewHeaderSectionDescription = kDetailTableViewHeaderSection(0)
let kDetailTableViewHeaderSectionLocation = kDetailTableViewHeaderSection(1)
let kDetailTableViewHeaderSectionPopularity = kDetailTableViewHeaderSection(2)
let kDetailTableViewHeaderSectionConstructed = kDetailTableViewHeaderSection(3)

class WOWDetailViewController: WOWBaseViewController, GVRWidgetViewDelegate, UITableViewDataSource, UITableViewDelegate {
	
	public var wonder: WOWWonder?
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var contentView: UIView!
	@IBOutlet weak var contentViewHeight: NSLayoutConstraint!
	
	@IBOutlet weak var imageView: UIImageView!
	@IBOutlet weak var panoramaView: GVRPanoramaView!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// Cell registration.
		tableView.register(WOWDetailHeaderFooterView.classNib(), forHeaderFooterViewReuseIdentifier: WOWDetailHeaderFooterView.classReuseIdentifier())
		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
		tableView.estimatedRowHeight = 44.0
		
		imageView.contentMode = .scaleAspectFill
		imageView.clipsToBounds = true
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

        guard let uwWonder = wonder else { return }

		let titleLabel: UILabel = UILabel.init(frame: CGRect.init(x: 0, y: 0, width: (navigationController?.view.bounds.size.width)! - 144.0, height: 44))
		titleLabel.text = uwWonder.title
		titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
		titleLabel.backgroundColor = UIColor.clear
		titleLabel.textColor = UIColor.white
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.minimumScaleFactor = 0.5
		titleLabel.textAlignment = .center
		navigationItem.titleView = titleLabel
		
		panoramaView.delegate = self
		panoramaView.enableFullscreenButton = true
		panoramaView.enableCardboardButton = true
		
		if uwWonder.isVR == true {
			panoramaView.isHidden = false
			imageView.isHidden = true
            let type: GVRPanoramaImageType = wonder!.vrMode! == "stereo" ? .stereoOverUnder : .mono
			panoramaView.load(UIImage.init(named: wonder!.fullImage!), of: type)
		} else {
			panoramaView.isHidden = true
			imageView.isHidden = false
			
			var image: UIImage?

            if let imgPath = uwWonder.fullImage {
                if (imgPath.count > 0) {
                    image = UIImage.init(named: imgPath)
                }
            } else if let pageImgPath = uwWonder.pageImage {
                if (pageImgPath.count > 0) {
                    image = UIImage.init(named: pageImgPath)
                }
            }

            imageView.image = image!
		}
		
		tableView.layoutIfNeeded()
		let tableViewSize: CGSize = tableView.contentSize
		
		contentViewHeight.constant = panoramaView.frame.size.height + tableViewSize.height + 20.0
		self.view.setNeedsLayout()
		
		scrollView.contentSize = CGSize.init(width: self.view.frame.size.width, height: contentViewHeight.constant)
	}

	//MARK: - GCSWidgetViewDelegate
    func widgetViewDidTap(_ widgetView: GVRWidgetView!) {}

    func widgetView(_ widgetView: GVRWidgetView!, didLoadContent content: Any!) {}

    func widgetView(_ widgetView: GVRWidgetView!, didChange displayMode: GVRWidgetDisplayMode) {
        DispatchQueue.main.async {
            UIApplication.shared.isStatusBarHidden = (displayMode == .fullscreen) || (displayMode == .fullscreenVR)
            self.navigationController?.setNeedsStatusBarAppearanceUpdate()
        }
    }

    func widgetView(_ widgetView: GVRWidgetView!, didFailToLoadContent content: Any!, withErrorMessage errorMessage: String!) {
        if let error = errorMessage { print(error) }
    }
	
	//MARK: - UITableViewDataSource
	func numberOfSections(in tableView: UITableView) -> Int {
		if wonder?.isManMade == true {
			return 4
		}
		return 3
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	//MARK: - UITableViewDelegate
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 52.0
	}
	
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {		
		
		let headerView: WOWDetailHeaderFooterView = tableView.dequeueReusableHeaderFooterView(withIdentifier: WOWDetailHeaderFooterView.classReuseIdentifier()) as! WOWDetailHeaderFooterView
		
		headerView.contentView.backgroundColor = UIColor.headerFooterColor()
		
		switch section {
			case Int(kDetailTableViewHeaderSectionDescription.value):
				headerView.contentImageView.image = UIImage.init(named: "icon_description")
				headerView.contentLabel.text = "Description"
				break
			
			case Int(kDetailTableViewHeaderSectionLocation.value):
				headerView.contentImageView.image = UIImage.init(named: "icon_location")
				headerView.contentLabel.text = "Location"
				break
			
			case Int(kDetailTableViewHeaderSectionPopularity.value):
				headerView.contentImageView.image = UIImage.init(named: "icon_popularity")
				headerView.contentLabel.text = "Popularity"
				break
			
			case Int(kDetailTableViewHeaderSectionConstructed.value):
				headerView.contentImageView.image = UIImage.init(named: "icon_constructed")
				headerView.contentLabel.text = "Constructed"
			
			default: break
		}
		
		return headerView
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		
		cell.textLabel?.textColor = UIColor.white
		cell.textLabel?.font = UIFont.init(name: "HelveticaNeue-Light", size: 15.0)
		cell.textLabel?.numberOfLines = 0
		cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
		cell.backgroundColor = UIColor.clear
		
		switch indexPath.section {
			case Int(kDetailTableViewHeaderSectionDescription.value):
				cell.textLabel?.text = wonder?.desc
				break
			
			case Int(kDetailTableViewHeaderSectionLocation.value):
				cell.textLabel?.text = wonder?.location
				break
			
			case Int(kDetailTableViewHeaderSectionPopularity.value):
				cell.textLabel?.text = wonder?.popularity
				break
			
			case Int(kDetailTableViewHeaderSectionConstructed.value):
				cell.textLabel?.text = wonder?.constructed
			
			default: break
		}
		
		return cell
		
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}
