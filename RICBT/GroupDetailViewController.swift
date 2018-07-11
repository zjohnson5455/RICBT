//
//  GroupDetailViewController.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/14/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.

//All mail code used from https://www.youtube.com/watch?v=fiFRxD0QQnY
//

import UIKit
import MessageUI

class GroupDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {
    @IBOutlet weak var label: UILabel!
    var text = ""
    @IBOutlet weak var proPic: UIImageView!
    var picture: UIImage = #imageLiteral(resourceName: "benJohnson")
    @IBOutlet weak var blurb: UILabel!
    var para = "Placeholder"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        label.text = text
        proPic.image = picture
        blurb.text = para
        blurb.sizeToFit()
    }
    
    func setPara(paragraph: String) {
        para = paragraph
        if (isViewLoaded) {
            blurb.text = paragraph
        }
    }
    
    func setPicture(p: UIImage) {
        picture = p
        if (isViewLoaded) {
            proPic.image = p
        }
    }
    
    func setText (t: String) {
        text = t
        if (isViewLoaded) {
            label.text = t
        }
    }
    
    
    
    @IBAction func onButtonClicked(_ sender: Any) {
        let mailComposeController = configureMailController()
        if MFMailComposeViewController.canSendMail() {
            self.present(mailComposeController, animated: true, completion: nil)
        }
        else {
            showMailError()
        }
    }
    
    func configureMailController () -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.mailComposeDelegate = self
        mailComposerVC.setToRecipients(["zacharyjohnsonri@gmail.com"])
        mailComposerVC.setSubject("Message regarding \(text)")
        mailComposerVC.setMessageBody("Please indicate your name, phone number, and message. We will get back to you shortly.", isHTML: false)
        return mailComposerVC
    }
    
    func showMailError() {
        let sendMailAlertError = UIAlertController(title: "Send Error", message: "Something went wrong when sending.", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "OK", style: .default, handler: nil)
        sendMailAlertError.addAction(dismiss)
        self.present(sendMailAlertError, animated: true, completion: nil)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
