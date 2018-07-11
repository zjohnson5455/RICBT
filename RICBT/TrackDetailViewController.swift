//
//  TrackDetailViewController.swift
//  RICBT
//
//  Created by Zachary Johnson on 3/20/18.
//  Copyright © 2018 ZacharyJohnson. All rights reserved.
//

import UIKit

class TrackDetailViewController: UIViewController {
    var dateText: String = ""
    var answers: [String] = []
    var ratings: [Float] = []
    var questions: [UITextView]!
    var sliders: [UISlider]!
    var masterView: FirstViewController!
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var titleForDay: UITextView!
    @IBOutlet weak var positiveAct: UITextView!
    @IBOutlet weak var preocc: UITextView!
    @IBOutlet weak var imptProj: UITextView!
    @IBOutlet weak var steps: UITextView!
    @IBOutlet weak var triggers: UITextView!
    @IBOutlet weak var otherActiv: UITextView!
    @IBOutlet weak var lessonsLearned: UITextView!
    @IBOutlet weak var enjRate: UISlider!
    @IBOutlet weak var distressRate: UISlider!
    @IBOutlet weak var wellBeingRate: UISlider!
    @IBOutlet weak var confRate: UISlider!
    @IBOutlet weak var stressRate: UISlider!
    @IBOutlet weak var anxietyRate: UISlider!
    @IBOutlet weak var depressRate: UISlider!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        date.text = dateText
        
        questions = [titleForDay, positiveAct, preocc, imptProj, steps, triggers, otherActiv, lessonsLearned]
        sliders = [enjRate, distressRate, wellBeingRate, confRate, stressRate, anxietyRate, depressRate]
        if (answers.count > 0) {
            print("Number of questions from detail Load:")
            print(questions.count)
            print("Answers from detail load")
            for answer in answers {
                print("-> \(answer)")
            }
            
            for index in 0...(answers.count - 1){
                print(index)
                questions[index].text = answers[index]
            }
        }
        if (ratings.count > 0) {
            for index in 0...(ratings.count - 1) {
                sliders[index].value = ratings[index]
            }
        }
    }
    
    func setData(date: String, answersFrom: [String], ratingsFrom: [Float]) {
        dateText = date
        answers = answersFrom
        ratings = ratingsFrom
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        answers.removeAll() //makes sure that when you save you don't have the remnants of the creation array
        ratings.removeAll()
        for index in 0...(questions.count - 1) {
            answers.insert(questions[index].text, at: index)
        }
        print("Answers from detail view:")
        for answer in answers {
            print(answer)
        }
        for index in 0...(sliders.count - 1) {
            ratings.insert(sliders[index].value, at: index)
        }
        print("Ratings from detail view:")
        for rating in ratings {
            print(rating)
        }
        masterView.setData(answersFrom: answers, ratingsFrom: ratings)
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
