//
//  ScoreViewController.swift
//  Quiz
//
//  Created by Theresa Gao on 3/18/16.
//  Copyright © 2016 iLabs. All rights reserved.
//

import Foundation

import UIKit

class ScoreViewController: UIViewController {
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var whatHappenedLabel: UILabel!
    override func viewDidLoad() {
        whatHappenedLabel.sizeToFit()
        whatHappenedLabel.text = "You managed to answer " + String(qsAnswered) + " questions!"
        playAgainButton.backgroundColor = UIColor.whiteColor()
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func playAgain(sender: UIButton) {
        let questionViewController : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        score = 0
        for key in entered.keys {
            entered[key] = 0
        }
        
        self.showViewController(questionViewController as! UIViewController, sender: questionViewController)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
}

