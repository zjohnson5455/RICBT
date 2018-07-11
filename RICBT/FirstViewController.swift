//
//  FirstViewController.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/13/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var dates: [String] = []
    var answers: [[String]] = []
    var ratings: [[Float]] = []
    var selectedRow: Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
        self.navigationItem.rightBarButtonItem = addButton
        self.navigationItem.leftBarButtonItem = editButtonItem
        load()
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellK")!
        cell.textLabel?.text = dates[indexPath.row]
        return cell
    }
    
    @objc func addNote(){
        if (tableView.isEditing) {
            return
        }
        //https://classictutorials.com/2015/07/how-to-get-current-day-month-and-year-in-nsdate-using-swift/
        let date = Date()
        let calendar = Calendar.current
        
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        let day = calendar.component(.day, from: date)
        
        let name: String = "\(month)/\(day)/\(year)"
        dates.insert(name, at: 0)
        answers.insert([""], at: 0)
        ratings.insert([5.0], at: 0)
        let indexPath: IndexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        save()
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        self.performSegue(withIdentifier: "detailTrack", sender: nil)
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dates.remove(at: indexPath.row)
        answers.remove(at: indexPath.row)
        ratings.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
        save()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detailTrack", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trackDetailView: TrackDetailViewController = segue.destination as! TrackDetailViewController
        selectedRow = tableView.indexPathForSelectedRow!.row
        print(selectedRow)
        trackDetailView.masterView = self
        trackDetailView.setData(date: dates[selectedRow], answersFrom: answers[selectedRow], ratingsFrom: ratings[selectedRow])
        
    }
    
    func setData(answersFrom: [String], ratingsFrom: [Float]) {
        answers[selectedRow] = answersFrom
        ratings[selectedRow] = ratingsFrom
        print("Answers from first view")
        for answer in answers {
            for ans in answer {
                print(ans)
            }
        }
        print("Ratings from firstView")
        for rating in ratings {
            for rat in rating {
                print(rat)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if selectedRow == -1 {
            return
        }
        if !((answers.count > 0) && (ratings.count > 0)) {
            dates.remove(at: selectedRow)
            answers.remove(at: selectedRow)
            ratings.remove(at: selectedRow)
        }
        tableView.reloadData()
        save()
    }
    
    func save() {
        UserDefaults.standard.set(dates, forKey: "Dates")
        UserDefaults.standard.set(answers, forKey: "Answers")
        UserDefaults.standard.set(ratings, forKey: "Ratings")
        UserDefaults.standard.synchronize()
    }

    func load() {
        if let loadedData = UserDefaults.standard.value(forKey: "Dates") as? [String] {
            dates = loadedData
        }
        if let loadedAnswers = UserDefaults.standard.value(forKey: "Answers") as? [[String]] {
            if (loadedAnswers.count > 0) {
                answers = loadedAnswers
            }
        }
        if let loadedRatings = UserDefaults.standard.value(forKey: "Ratings") as? [[Float]] {
            if (loadedRatings.count > 0) {
                ratings = loadedRatings
            }
            
        }
        
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

