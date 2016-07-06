//
//  SettingsTableViewController.swift
//  Survata Says
//
//  Created by Theresa Gao on 7/7/16.
//  Copyright © 2016 iLabs. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet weak var demoModeCell: UITableViewCell!
    @IBOutlet weak var demoModeLabel: UILabel!
    @IBOutlet weak var demoModeSwitch: UISwitch!
    @IBOutlet weak var goBackButton: UIButton!
    @IBOutlet weak var footerView: UIView!
    
    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    let demoModeKey = "demoModeSettings"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoModeSwitch.on = NSUserDefaults.standardUserDefaults().boolForKey(demoModeKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    @IBAction func demoModeChanged(sender: UISwitch) {
        demoModeSwitch.on = (sender as UISwitch).on
        NSUserDefaults.standardUserDefaults().setBool(demoModeSwitch.on, forKey: demoModeKey)
        NSUserDefaults.standardUserDefaults().synchronize()

    }
    @IBAction func saveChangesAndGoBack(sender: UIButton) {
        NSUserDefaults.standardUserDefaults().synchronize()
        let questionViewController : AnyObject! = self.storyboard!.instantiateViewControllerWithIdentifier("QuestionViewController") as! QuestionViewController
        self.showViewController(questionViewController as! UIViewController, sender: questionViewController)
    }
    
    
}
