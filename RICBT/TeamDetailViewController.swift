//
//  TeamDetailViewController.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/17/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.
//

import UIKit
import MessageUI

class TeamDetailViewController: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var pic: UIImageView!
    var picture: UIImage = #imageLiteral(resourceName: "benJohnson")
    @IBOutlet weak var para: UILabel!
    var paragraph: String = ""
    @IBOutlet weak var name: UILabel!
    var text = ""
    @IBOutlet weak var myButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        name.text = text
        pic.image = picture
        para.text = paragraph
        para.sizeToFit()
    }
    
    func setText (t: String) {
        text = t
        if (isViewLoaded) {
            name.text = t
        }
    }
    
    func setPara(p: String) {
        paragraph = p
        if (isViewLoaded) {
            para.text = p
        }
    }
    
    func setPicture(picto: UIImage) {
        picture = picto
        if (isViewLoaded) {
            pic.image = picto
        }
    }
    
    @IBAction func availButtonTapped(_ sender: Any) {
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
