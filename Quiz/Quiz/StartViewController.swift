//
//  StartViewController.swift
//  Quiz
//
//  Created by Theresa Gao on 3/18/16.
//  Copyright © 2016 iLabs. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    @IBOutlet weak var letsPlay: UILabel!
    @IBOutlet weak var scoreBackground: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func startQuiz(sender: UIButton) {
        let questionViewController : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        self.showViewController(questionViewController as! UIViewController, sender: questionViewController)
    }
    

   
}
