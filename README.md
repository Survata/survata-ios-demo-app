# survata-ios-demo-app

## 1. Clone the git repository locally. 

Make sure you have the latest updates to the repository.
ie. ‘git pull’

Note: We assume that you already have a project in Xcode and that this project is opened in Xcode 7 or later.
The SDK supports iOS 8.0 and later.

## 2. Run "pod install" in order to install all the necessary modules. 
If your computer doesn't recognize pod, it's because you don't have Cocoapods installed. Go install it!

Once you have that installed, it should create a .xcworkspace. Use that instead of the .xcodeproj. 

while "pod install" is running, if it begins to hang for a long time:
try running these commands...
```
pod repo remove master
pod setup
pod install
```

## 3. Integrating The Survata SDK
You can display it in your project however you like, but I chose to use a UIView, an ActivityIndicatorView, and a Button in order to trigger the creation of the survey. 
```swift
    @IBOutlet weak var surveyMask: GradientView!
    @IBOutlet weak var surveyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scoreButton: UIButton!
```
Then, I used the function "createSurvey()" to create the survey. Initialize it with the appropriate properties such as publisherId, zipcode, etc. 

```swift
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
    
```
As you can probably tell, I created a Settings.swift file to store my information. This is part of it.
```swift
struct Settings {
	static var publisherId: String! = "survata-test"
	static var previewId: String! = "46b140a358cd4fe7b425aa361b41bed9"
	static var contentName: String!
	static var forceZipcode: String!
	static var sendZipcode: Bool = true
}
```

If the survey is created successfully, I triggered the showSurveyButton() and showFull() functions to display them.
```swift
func showFull() {
       surveyMask.hidden = true
    
    }
    
    func showSurveyButton() {
        surveyMask.hidden = false
        surveyButton.hidden = false
        surveyIndicator.stopAnimating()
    }
```
After that, when the button is displayed, I defined a function called startSurvey() that will display the survey once the button is tapped (createSurveyWall()). 
```swift
@IBAction func startSurvey(sender: UIButton) {
        if (survey != nil){
            score -= 100
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
```

If everything works 🙏, it should display the survey!





