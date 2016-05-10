//
//  QuestionTableViewController.swift
//  SurvataDemo
//
//  Created by Theresa Gao on 3/1/16.
//  Copyright © 2016 InteractiveLabs. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD
import Greycats
import Survata

var score = 0
var entered = [Int: Int]()
var qsAnswered = 0
var failed = false 




class QuestionTableViewController: UIViewController {
    
    @IBOutlet weak var surveyMask: GradientView!
    @IBOutlet weak var surveyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scoreButton: UIButton!
    @IBOutlet weak var scoreLabel2: UILabel!
    //MARK: Properties
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var downButton: UIButton!
    @IBOutlet weak var surveyButton: UIButton!
    
    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var questionLabelTop: UILabel!
    
    var questions = [Question]()
    var percentage = 50
    var ind = 0
    //var score = 0
    var qsAnswered = 0
    var actualPercentages : [Int] = []
    var survey: Survey!
    var currentQ: Question!
    var counter1:Int = 100 {
        didSet {
            let fractionalProgress = Float(counter1) / 100.0
            let animated = counter1 != 0
            progressView.setProgress(fractionalProgress, animated: animated)
            progressLabel.text = String(("\(counter1)%"))
        }
    }
    @IBAction func upPercentage(sender: UIButton) {
        if percentage < 100 {
            percentage += 1
            storePercentage(ind, percentage: percentage)
            percentageLabel.text = "\(percentage)"
        }
    }
    @IBAction func lowerPercentage(sender: UIButton) {
        if percentage > 0 {
            percentage -= 1
            storePercentage(ind, percentage: percentage)
            percentageLabel.text = "\(percentage)"
        }
    }
    
    func storePercentage(currentInd: Int, percentage: Int) {
        entered[currentInd] = percentage
    }
    
    @IBAction func nextQuestion(sender: AnyObject)
    {
        if (counter1 <= 0){
            checkIfEnd(counter1)
            print("Game is over")
        } else {
            print(ind)
            qsAnswered += 1
            questionLabelTop.text = "Question #" + String(ind+2)
            percentage = 50
            percentageLabel.text = String(percentage)
            currentQ = questions[ind]
            if ind == entered.count - 1{
                let scoreViewController : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ScoreViewController") as! ScoreViewController
                
                self.showViewController(scoreViewController as! UIViewController, sender: scoreViewController)
            } else {
                print("IND IS: " + String(ind))
                print("COUNTER IS: " + String(counter1))
                print("ACTUAL IS: " + String(actualPercentages[ind]))
                print("WHAT YOU ENTERED IS: "+String(entered[ind]))
                print("DIFFERENCE IS: " + String(entered[ind]! - actualPercentages[ind]))
                counter1 -= abs(entered[ind]! - actualPercentages[ind])
                progressView.setProgress(Float(counter1), animated: true)
                progressLabel.text = String(("\(counter1)%"))
                
                ind += 1
                currentQ = questions[ind]
                questionLabel.text = currentQ.name
            }
        }
    }
    
    func checkIfEnd(counter1: Int) -> Bool{
        score = counter1
        if counter1 <= 0 || ind >= 17 {
            if counter1 <= 0 {
                failed = true
                let scoreViewController : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ScoreViewController") as! ScoreViewController
                
                self.showViewController(scoreViewController as! UIViewController, sender: scoreViewController)
            } else if ind >= 17 {
                failed = false
                let scoreViewController : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("ScoreViewController") as! ScoreViewController
                
                self.showViewController(scoreViewController as! UIViewController, sender: scoreViewController)
            }
            return true
        } else {
            return false
        }
    }
    
    @IBAction func previousQuestion(sender: UIButton) {
        if ind > 0 {
            ind -= 1
        }
        currentQ = questions[ind]
        questionLabel.text = currentQ.name
        
    }
    
    override func viewDidLoad() {
        questionLabel.sizeToFit()
        surveyIndicator.hidden = true
        super.viewDidLoad()
        let longPressUp = UILongPressGestureRecognizer(target: self, action: "handleLongUpPress:")
        addButton.addGestureRecognizer(longPressUp)
        let longPressDown = UILongPressGestureRecognizer(target: self, action: "handleLongDownPress:")
        downButton.addGestureRecognizer(longPressDown)
        loadSampleQuestions()
    }
    
    func handleLongUpPress(gesture: UILongPressGestureRecognizer) {
        if(gesture.state == .Began){
            percentage = percentage + 10
            storePercentage(ind, percentage: percentage)
            if percentage < 100 {
                percentageLabel.text = "\(percentage)"
            }
        }
    }
    func handleLongDownPress(gesture: UILongPressGestureRecognizer) {
        if(gesture.state == .Began){
            percentage = percentage - 10
            storePercentage(ind, percentage: percentage)
            if percentage > 0 {
                percentageLabel.text = "\(percentage)"
            }
        }
    }
    
    func loadSampleQuestions() {
        let q1 = Question(name: "Guess the % of people who said BLUE was their favorite color.", percentage: 30)
        let q2 = Question(name: "Guess the % of people who said they eat candy at least once per day", percentage: 13)
        let q3 = Question(name: "Guess the % of people who most often watch TV shows live on television", percentage: 47)
        let q4 = Question(name: "Guess the % of people who said Coke was their favorite soda", percentage: 26)
        let q5 = Question(name: "Guess the % of people who use Facebook the most", percentage: 64)
        let q6 = Question(name: "Guess the % of people who prefer cats over dogs", percentage: 20)
        let q7 = Question(name: "Guess the % of people who are solely introverts", percentage: 30)
        let q8 = Question(name: "Guess the % of people who said rap was their favorite genre of music", percentage: 6)
        let q9 = Question(name: "Guess the % of people who said American food was their favorite kind of food", percentage: 25)
        let q10 = Question(name: "Guess the % of people who said Cookie Dough was their favorite ice cream flavor", percentage: 11)
        let q11 = Question(name: "Guess the % of people who said that Taco Bell was their favorite fast-food chain", percentage: 12)
        let q12 = Question(name: "Guess the % of people who said that Action was their favorite movie genre", percentage: 16)
        let q13 = Question(name: "Guess the % of people who don't have a favorite brand of gum", percentage: 33)
        let q14 = Question(name: "Guess the % of people who said black coffee was their favorite coffee drink", percentage: 21)
        let q15 = Question(name: "Guess the % of people who said beef is their favorite meat", percentage: 37)
        let q16 = Question(name: "Guess the % of people who said that the beach is their ideal vacation spot", percentage: 45)
        let q17 = Question(name: "Guess the % of people who said that leggings are their favorite pants", percentage: 9)
        let q18 = Question(name: "Guess the % of people who haven't been to any other country", percentage: 33)
        let q19 = Question(name: "Guess the % of people who said that Family Guy was their favorite guilty pleasure TV show", percentage: 15)
        let q20 = Question(name: "Guess the % of people who said that One Direction was their favorite boy band", percentage: 7)
        let q21 = Question(name: "Guess the % of people who said that Finding Nemo was their favorite animated movie", percentage: 17)
        let q22 = Question(name: "Guess the % of people who said that peaches was their favorite fruit", percentage: 14)
        let q23 = Question(name: "Guess the % of people who said that tea was their favorite beverage", percentage: 15)
        let q24 = Question(name: "Guess the % of people who said that orange juice was their favorite juice", percentage: 33)
        let q25 = Question(name: "Guess the % of people who don't have a favorite superhero", percentage: 20)
        let q26 = Question(name: "Guess the % of people who said that Sriracha was their favorite condiment", percentage: 4)
        let q27 = Question(name: "Guess the % of people who said that Call of Duty was their favorite video game", percentage: 9)
        let q28 = Question(name: "Guess the % of people who said that Youtube was their favorite music platform", percentage: 20)
        let q29 = Question(name: "Guess the % of people who said that Internet Explorer was their favorite Internet browser", percentage: 13)
        let q30 = Question(name: "Guess the % of people who said that swimming was their favorite sport", percentage: 9)
        let q31 = Question(name: "Guess the % of people who said that Fox News was their favorite news source", percentage: 20)
        let q32 = Question(name: "Guess the % of people who watch 5+ hours of TV daily", percentage: 21)
        let q33 = Question(name: "Guess the % of people who don't speak a second language", percentage: 77)
        let q34 = Question(name: "Guess the % of people who wish invisibility could be their superpower", percentage: 20)
        let q35 = Question(name: "Guess the % of people who would want to be the smartest person in the world", percentage: 41)
        let q36 = Question(name: "Guess the percentage of people who would want to be a penguin for a day", percentage: 5)
        let q37 = Question(name: "Guess the % of people who spend most of their money on food", percentage: 34)
        let q38 = Question(name: "Guess the % of people who said that New York City was the best city in the USA", percentage: 20)
        let q39 = Question(name: "Guess the % of people who said that Orange is The New Black is their favorite Netflix original show", percentage: 10)
        let q40 = Question(name: "Guess the % of people who said that winter is their favorite season", percentage: 7)
        let q41 = Question(name: "Guess the percentage of people who said that Christmas/Hanukkah/Kwanzaa was their favorite holiday", percentage: 43)
        let q42 = Question(name: "Guess the percentage of people who don't have a favorite Starburst flavor", percentage: 37)
        let q43 = Question(name: "Guess the percentage of people who prefer Android over iPhone", percentage: 28)
        let q44 = Question(name: "Guess the % of people who said that McDonald's was their favorite coffee chain", percentage: 6)
        let arr = [Question](arrayLiteral: q1!, q2!, q3!, q4!, q5!, q6!, q7!, q8!, q9!, q10!, q11!, q12!, q13!, q14!, q15!, q16!, q17!, q18!, q19!, q20!, q21!, q22!, q23!, q24!, q25!, q26!, q27!, q28!, q29!, q30!, q31!, q32!, q33!, q34!, q35!, q36!, q37!, q38!, q39!, q40!, q41!, q42!, q43!, q44!)
        questionLabel.text = arr[0].name
        var i = 0
        for q in arr {
            questions.append(q)
            actualPercentages.append(q.percentage)
            entered[i] = 50
            i += 1

        }
    }
        override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var created = false
    var locationManager: CLLocationManager!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
            createSurvey()
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            createSurvey()
        }
        if status != .NotDetermined {
            locationManager = nil
        }
    }
    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent?) {
        if motion == .MotionShake {
            if presentedViewController != nil { return }
            let controller = UIAlertController(title: "Reset Demo?", message: nil, preferredStyle: .Alert)
            let option = UIAlertAction(title: "Reset", style: .Destructive) {[weak self] _ in
                guard let window = self?.view.window, storyboard = self?.storyboard else { return }
                NSHTTPCookieStorage.sharedHTTPCookieStorage().removeCookiesSinceDate(NSDate(timeIntervalSince1970: 0))
                window.rootViewController = storyboard.instantiateInitialViewController()
            }
            controller.addAction(option)
            controller.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
            presentViewController(controller, animated: true, completion: nil)
        }
    }
    
    func showFull() {
       surveyMask.hidden = true
    
    }
    
    func showSurveyButton() {
        surveyMask.hidden = false
        surveyButton.hidden = false
        surveyIndicator.stopAnimating()
    }
    
    @IBAction func startSurvey(sender: UIButton) {
        if (survey != nil){
            if(counter1 + 20 <= 100){
                counter1 += 20
            } else {
                counter1 = 100
            }
            survey.createSurveyWall { result in
                delay(2) {
                    SVProgressHUD.dismiss()
                }
                switch result {
                case .Completed:
                    SVProgressHUD.showInfoWithStatus("'surveyWall': completed")
                    return
                case .Canceled:
                    SVProgressHUD.showInfoWithStatus("'surveyWall': canceled")
                case .CreditEarned:
                    SVProgressHUD.showInfoWithStatus("'surveyWall': credit earned")
                case .NetworkNotAvailable:
                    SVProgressHUD.showInfoWithStatus("'surveyWall': network not available")
                case .Skipped:
                    SVProgressHUD.showInfoWithStatus("'surveyWall': skipped")
                }
            }
        } else {
            print("survey is nil")
        }
    }
   
    func createSurvey() {
        if created { return }
        let option = SurveyDebugOption(publisher: Settings.publisherId)
        option.preview = Settings.previewId
        option.zipcode = Settings.forceZipcode
        option.sendZipcode = Settings.sendZipcode
        option.contentName = Settings.contentName
        survey = Survey(option: option)
        
        survey.create {[weak self] result in
            self?.created = true
            switch result {
            case .Available:
                self?.showSurveyButton()
            default:
                self?.showFull()
            }
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
