//
//  WOWSettingsViewController.swift
//  wondersoftheworld
//
//  Created by Andy Shephard on 13/04/2017.
//  Copyright © 2017 Andy Shephard. All rights reserved.
//

import UIKit
import MessageUI

class WOWSettingsViewController: WOWBaseTableViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.title = "Settings"
		
    }
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		switch indexPath.section {
		case 0:
			if (indexPath.row == 0) {
				// Rate us.
				rateApp()
			} else if (indexPath.row == 1) {
				// Feedback.
				sendFeedback()
			}
			break
		case 1:
			// Other apps by developer.
			showOtherApps()
			break
		default:
			break
		}
	}
	
	func rateApp() {
		
		let rateUrl = URL(string: "itms-apps://itunes.apple.com/app/1225189019".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
		let possible = UIApplication.shared.canOpenURL(rateUrl!)
		
		if (possible) {
			UIApplication.shared.open(rateUrl!, options: [:], completionHandler: nil)
		}
	}
	
	func showOtherApps() {
		let devUrl = URL(string: "itms://itunes.apple.com/us/developer/andyshephard-com-limited/id663805934?uo=4".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
		let possible = UIApplication.shared.canOpenURL(devUrl!)
		
		if (possible) {
			UIApplication.shared.open(devUrl!, options: [:], completionHandler: nil)
		}
	}
	
	func sendFeedback() {
		let mailComposeViewController = configuredMailComposeViewController()
		if MFMailComposeViewController.canSendMail() {
			self.present(mailComposeViewController, animated: true, completion: nil)
		} else {
			self.showSendMailErrorAlert()
		}
	}
	
	func configuredMailComposeViewController() -> MFMailComposeViewController {
		let mailComposerVC = MFMailComposeViewController()
		mailComposerVC.mailComposeDelegate = self // Extremely important to set the --mailComposeDelegate-- property, NOT the --delegate-- property
		
		mailComposerVC.setToRecipients(["support@andy-shephard.com"])
		mailComposerVC.setSubject("Feedback for Wonders of the World iOS App")
		mailComposerVC.setMessageBody("Enter your feedback here: ", isHTML: false)
		
		return mailComposerVC
	}
	
	func showSendMailErrorAlert() {
		let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email. Please check your email configuration and try again.", preferredStyle: .alert)
		let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
		sendMailErrorAlert.addAction(okButton)
		sendMailErrorAlert.show(self, sender: self)
	}
	
	// MARK: MFMailComposeViewControllerDelegate Method
	func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
		controller.dismiss(animated: true, completion: nil)
	}
}
