//
//  SecondViewController.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/13/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle!
    
    var data: [String] = []
    let images: [UIImage] = [#imageLiteral(resourceName: "youngAdultSized.jpeg"), #imageLiteral(resourceName: "dbtSized.JPG"), #imageLiteral(resourceName: "adhdSized.jpg"), #imageLiteral(resourceName: "positivePsychTiny.jpg"), #imageLiteral(resourceName: "relaxationSized.jpeg"), #imageLiteral(resourceName: "beYourBestYouSized.jpg"), #imageLiteral(resourceName: "managingMoodSized.jpg"), #imageLiteral(resourceName: "weightLossSized.jpg")]
    let profiles: [UIImage] = [#imageLiteral(resourceName: "deirdreMurphy"), #imageLiteral(resourceName: "heatherSchatten"), #imageLiteral(resourceName: "selene"), #imageLiteral(resourceName: "sharonYounkin"), #imageLiteral(resourceName: "deirdreMurphy"), #imageLiteral(resourceName: "deirdreMurphy"), #imageLiteral(resourceName: "juliePearson"), #imageLiteral(resourceName: "pattyEngler")]
    var blurbs: [String] = []
    var selectedRow: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        databaseHandle = ref?.child("Groups").observe(.value) { (snapshot) in
            //the code to execute when value in database is changed

            //clear arrays so you don't have redundancies if you change a value
            self.data.removeAll()
            self.blurbs.removeAll()
            
            //take value from snapshot and add it to the appropriate array
            let children = snapshot.children
            while let rest = children.nextObject() as? DataSnapshot {
                let groupName = rest.key
                // https://stackoverflow.com/questions/48755746/new-line-command-n-not-working-with-firebase-firestore-database-strings?rq=1
                let finalName = groupName.replacingOccurrences(of: "\\n", with: "\n")
                let groupBlurb = rest.value as! String
                let finalBlurb = groupBlurb.replacingOccurrences(of: "\\n", with: "\n")
                self.data.append(finalName)
                self.blurbs.append(finalBlurb)
            }
            
            
            
            //reload tableView to demonstrate changes
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomGroupCell
        cell.title.text = data[indexPath.row]
        cell.pic.image = images[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailGroup", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: GroupDetailViewController = segue.destination as! GroupDetailViewController
        selectedRow = tableView.indexPathForSelectedRow!.row
        detailView.setText(t: data[selectedRow])
        detailView.setPicture(p: profiles[selectedRow])
        detailView.setPara(paragraph: blurbs[selectedRow])
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

