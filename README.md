# survata-ios-demo-app

 Demo app for the Survata SDK. iOS SDK is located [here](https://github.com/Survata/survata-ios-public-sdk).

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
### Step 1
You can display it in your project however you like, but I chose to use a UIView, an ActivityIndicatorView, and a Button in order to trigger the creation of the survey. 
```swift
    @IBOutlet weak var surveyMask: GradientView!
    @IBOutlet weak var surveyIndicator: UIActivityIndicatorView!
    @IBOutlet weak var scoreButton: UIButton!
```
### Step 2
Then, I used the function "createSurvey()" to create the survey. Initialize it with the property publisherId. 

```swift
func createSurvey() {
        if created { return }
        let option = SurveyOption(publisher: Settings.publisherId)
        option.contentName = Settings.contentName // optional
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

#### Explaining contentName 
`option.contentName` enforces that there is one survey per respondent per contentName. For example, if using a survey to unlock a level in a game or an e-book, it allows the publisher to offload enforcing that unlocking to be permanent onto us. 

For example, if there's a game and there's a level 7. If a person playing the game has already earned the survey for level 7, if they request a survey for level 7 again, it shows that they already earned it. 

You can pass a timestamp as the contentName if you would like to handle the logic of content availability on your side.
 * If you do not set contentName, a user will only ever be able to take one survey.

#### IMPORTANT NOTE

There is a frequency cap on how many surveys we allow one day for a specific IP address. Thus while testing/developing, it might be frustrating to not see surveys appear after a couple of tries. You can bypass this in two ways. 

####1. FIRST WAY: Using "testing" property

There is a property called **testing** which is a boolean that can be set to true. Below is a snippet of the previous code above that includes the testing property. This will bring up real surveys (that might take very long to answer, so look at the second way), but your responses are not recorded.

```swift
    let option = SurveyOption(publisher: Settings.publisherId)
    option.testing = true
```

####2. SECOND WAY: Using a default survey with SurveyOption, "preview" property & demo survey preview id 

There is a property called **preview** that allows you to set a default preview Id for a survey (thus, have a specific survey). We have a default short demo survey with just 3 questions at Survata that is perfect for testing that uses the preview id **5fd725139884422e9f1bb28f776c702d**. Here's some code as to show you how to integrate it: 

```swift
    let option = SurveyOption(publisher: Settings.publisherId)
    option.preview = "5fd725139884422e9f1bb28f776c702d"
```

### Step 3

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
### Step 4 
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
### Step 5 
After that, when the button is displayed, I defined a function called startSurvey() that will display the survey once the button is tapped (createSurveyWall()). It also returns the events -- COMPLETED, CANCELED, CREDIT_EARNED, NETWORK_NOT_AVAILABLE, and NO_SURVEY_AVAILABLE (ex. people under 13, people taking multiple surveys and being capped at our frequency cap). 
```swift
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
                    SVProgressHUD.showInfoWithStatus("Completed")
                case .Canceled:
                    SVProgressHUD.showInfoWithStatus("Canceled")
                case .CreditEarned:
                    SVProgressHUD.showInfoWithStatus("Credit earned")
                case .NetworkNotAvailable:
                    SVProgressHUD.showInfoWithStatus("Network not available")
                case .Skipped:
                    SVProgressHUD.showInfoWithStatus("Skipped")
                case .NoSurveyAvailable:
                    SVProgressHUD.showInfoWithStatus("No survey available")
                default:
                    SVProgressHUD.showInfoWithStatus("no opp")
                }
            }
        } else {
            print("survey is nil")
        }
    }
```

If everything works 🙏, it should display the survey!





