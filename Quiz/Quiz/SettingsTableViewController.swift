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
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let demoModeKey = "demoModeSettings"

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoModeSwitch.isOn = UserDefaults.standard.bool(forKey: demoModeKey)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    @IBAction func demoModeChanged(_ sender: UISwitch) {
        demoModeSwitch.isOn = (sender as UISwitch).isOn
        UserDefaults.standard.set(demoModeSwitch.isOn, forKey: demoModeKey)
        UserDefaults.standard.synchronize()

    }
    @IBAction func saveChangesAndGoBack(_ sender: UIButton) {
        UserDefaults.standard.synchronize()
        let questionViewController : AnyObject! = self.storyboard!.instantiateViewController(withIdentifier: "QuestionViewController") as! QuestionViewController
        self.show(questionViewController as! UIViewController, sender: questionViewController)
    }
    
    
}
