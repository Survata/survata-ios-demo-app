//
//  ViewController.swift
//  Demo
//
//  Created by Rex Sheng on 2/11/16.
//  Copyright © 2016 Survata. All rights reserved.
//

import Survata
import CoreLocation

class DemoViewController: UIViewController, CLLocationManagerDelegate {
	
	@IBOutlet weak var surveyMask: UIView!
    @IBOutlet weak var surveyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var surveyButton: UIButton!
    
    var created = false
	var locationManager: CLLocationManager!
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		if CLLocationManager.authorizationStatus() == .notDetermined {
			locationManager = CLLocationManager()
			locationManager.delegate = self
			locationManager.requestWhenInUseAuthorization()
		} else {
			createSurvey()
		}
	}
	
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedWhenInUse {
			createSurvey()
		}
		if status != .notDetermined {
			locationManager = nil
		}
	}
	
	override var canBecomeFirstResponder: Bool { return true }
	
	override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
		if motion == .motionShake {
			if presentedViewController != nil { return }
			let controller = UIAlertController(title: "Reset Demo?", message: nil, preferredStyle: .alert)
			let option = UIAlertAction(title: "Reset", style: .destructive) {[weak self] _ in
				guard let window = self?.view.window, let storyboard = self?.storyboard else { return }
				HTTPCookieStorage.shared.removeCookies(since: NSDate(timeIntervalSince1970: 0) as Date)
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
		surveyMask.isHidden = false
		surveyButton.isHidden = false
		surveyIndicator.stopAnimating()
	}
	
    @IBAction func startSurvey(_ sender: UIButton) {
        
    }
    
	func createSurvey() {
		if created { return }
        }
}
