//
//  QuestionViewController.swift
//  Survata Says
//
//  Created by Theresa Gao on 5/23/16.
//  Copyright © 2016 iLabs. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD
import Greycats
import Survata


var entered = [Int: Int]()
var qsAnswered = 0
var failed = false

class QuestionViewController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var percentageSlider: UISlider!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var takeSurveyLabel: UILabel!
    @IBOutlet weak var takeSurveyButton: UIButton!
    @IBOutlet weak var lifeView: UIView!
    @IBOutlet weak var percentageLabel: UILabel!
    @IBOutlet weak var surveyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var surveyMask: GradientView!
    @IBOutlet weak var heart: UIImageView!
    @IBOutlet weak var lifeLabelTest: UILabel!
    @IBOutlet weak var settingsButton: UIButton!
    
    
    var questions = [Question]()
    var percentage = 50
    var ind = 1
    var actualPercentages : [Int] = []
    var survey: Survey!
    var currentQ: Question!
    var counter1:Int = 100
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var demoMode: Bool? {
        get {
            return UserDefaults.standard.bool(forKey: "demoModeSettings")
        }
    }
    
   
    @IBAction func goToSettingsPage(_ sender: UIButton) {
        let settingsViewController : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
        self.show(settingsViewController as! UIViewController, sender: settingsViewController)

    }
    @IBAction func percentageSliderValueChanged(_ sender: UISlider) {
        percentage = Int(sender.value)
        percentageLabel.text = "\(percentage)"
    }
    func randomInt(_ min: Int, max:Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
    
    func storePercentage(_ currentInd: Int, percentage: Int) -> Int {
        entered[currentInd] = percentage
        return percentage
    }
    
    @IBAction func nextQuestion(_ sender: UIButton) {
        let guess = storePercentage(ind, percentage: Int(percentageSlider.value))
        let difference = abs(guess - actualPercentages[ind])
        var randomNumber = randomInt(0, max: entered.count)
        if (counter1 - difference <= 0){
            lifeLabelTest.text = "0%"
            let scoreViewController : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
            self.show(scoreViewController as! UIViewController, sender: scoreViewController)
        } else {
            print(ind)
            qsAnswered += 1
            //percentageLabel.text = String(percentage)
            currentQ = questions[ind]
            if ind == entered.count - 1{
                let scoreViewController : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
                
                self.show(scoreViewController as! UIViewController, sender: scoreViewController)
            } else {
                counter1 -= difference
                lifeLabelTest.text = "\(counter1)%"
                randomNumber = randomInt(0, max: entered.count - 1)
                ind = randomNumber
                currentQ = questions[ind]
                questionLabel.text = currentQ.name
            }
        }

    }
   
    
    func checkIfEnd(_ counter1: Int){
        
        let scoreViewController : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
        self.show(scoreViewController as! UIViewController, sender: scoreViewController)
    }
    
    
    override func viewDidLoad() {
        
        lifeLabelTest.text = "\(counter1)%"
        takeSurveyLabel.text = "Take a survey to increase your life by 20%!"
        surveyIndicator.isHidden = true
        loadSampleQuestions()
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
    
    var locationManager: CLLocationManager!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        checkSurvey()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            checkSurvey()
        }
        if status != .notDetermined {
            locationManager = nil
        }
    }
    
    override var canBecomeFirstResponder : Bool {
        return true
    }
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            if presentedViewController != nil { return }
            let controller = UIAlertController(title: "Reset Demo?", message: nil, preferredStyle: .alert)
            let option = UIAlertAction(title: "Reset", style: .destructive) {[weak self] _ in
                guard let window = self?.view.window, let storyboard = self?.storyboard else { return }
                HTTPCookieStorage.shared.removeCookies(since: Date(timeIntervalSince1970: 0))
                window.rootViewController = storyboard.instantiateInitialViewController()
            }
            controller.addAction(option)
            controller.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(controller, animated: true, completion: nil)
        }
    }
    
    func showFull() {
        surveyMask.isHidden = true
    }
    
    func showSurveyButton() {
        self.takeSurveyButton.isHidden = false
        self.takeSurveyLabel.isHidden = false
        surveyIndicator.stopAnimating()
    }
    
    @IBAction func startSurvey(_ sender: UIButton) {
        if (survey != nil){
            if(counter1 + 20 <= 100){
                counter1 += 20
            } else {
                counter1 = 100
            }
            lifeLabelTest.text = "\(counter1)%"
            survey.createSurveyWall { result in
                let _ = delay(2) {
                    SVProgressHUD.dismiss()
                }
                switch result {
                    
                case .completed:
                    SVProgressHUD.showInfo(withStatus: "Completed")
                case .canceled:
                    SVProgressHUD.showInfo(withStatus: "Canceled")
                case .creditEarned:
                    SVProgressHUD.showInfo(withStatus: "Credit earned")
                case .networkNotAvailable:
                    SVProgressHUD.showInfo(withStatus: "Network not available")
                case .skipped:
                    SVProgressHUD.showInfo(withStatus: "Skipped")
                case .noSurveyAvailable:
                    SVProgressHUD.showInfo(withStatus: "No survey available")
                }
                self.checkSurvey()
            }
        } else {
            print("survey is nil")
        }
    }
    
    func checkSurvey() {
        let option = SurveyOption(publisher: Settings.publisherId)
        if let demoMode = demoMode {
            if(demoMode){ // Demo Mode On
                option.testing = true
                option.preview = "5fd725139884422e9f1bb28f776c702d"// preview id for fixed survata survey
                self.showSurveyButton()
            }
        } else { // if demoMode == nil, just assume regular mode
            option.contentName = String(describing: Date())
        }

        option.contentName = String(describing: Date())
        
        survey = Survey(option: option)

        survey.create {[weak self] result in
            guard let strongSelf = self else {
                print("Something went wrong")
                return
            }
            if let demoMode = strongSelf.demoMode, demoMode {
                strongSelf.showSurveyButton()
                print("demo version")
            } else {
                switch result {
                    case .available:
                        strongSelf.showSurveyButton()
                    case .notAvailable:
                        strongSelf.takeSurveyButton.isHidden = true
                        strongSelf.takeSurveyLabel.isHidden = true
                        print("Debug reference unavailable.")

                    default:
                        print(result)
                        strongSelf.takeSurveyButton.isHidden = true
                        strongSelf.takeSurveyLabel.isHidden = true
                }
            }
        }
    }

}
