//
//  ThirdViewController.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/17/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseStorageUI

class ThirdViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var data: [String] = []
    var images: [UIImage] = [#imageLiteral(resourceName: "aaronKaiser"), #imageLiteral(resourceName: "benJohnson"), #imageLiteral(resourceName: "deirdreMurphy"), #imageLiteral(resourceName: "selene")]
    var descrip: [String] = []
    var selectedRow: Int = -1
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference()
        
        
        databaseHandle = ref?.child("Clinicians").observe(.value) { (snapshot) in
            //the code to execute when value in database is changed
            
            //clear arrays so you don't have redundancies if you change a value
            self.data.removeAll()
            self.descrip.removeAll()
            
            // Reference to an image file in Firebase Storage
            // let reference = storageRef.child("aaronKaiser.png")
            

            
            //take value from snapshot and add it to the appropriate array
            let children = snapshot.children
            while let rest = children.nextObject() as? DataSnapshot {
                let name = rest.key
                // https://stackoverflow.com/questions/48755746/new-line-command-n-not-working-with-firebase-firestore-database-strings?rq=1
                let finalName = name.replacingOccurrences(of: "\\n", with: "\n")
                let blurb = rest.value as! String
                let finalBlurb = blurb.replacingOccurrences(of: "\\n", with: "\n")
                self.data.append(finalName)
                self.descrip.append(finalBlurb)
            }
            
            
            //reload tableView to demonstrate changes
            self.tableView.reloadData()
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellT", for: indexPath) as! CustomTeamCell
        cell.name.text = data[indexPath.row]
        cell.pic.image = images[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailTeam", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailView: TeamDetailViewController = segue.destination as! TeamDetailViewController
        selectedRow = tableView.indexPathForSelectedRow!.row
        detailView.setText(t: data[selectedRow])
        detailView.setPara(p: descrip[selectedRow])
        detailView.setPicture(picto: images[selectedRow])
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
