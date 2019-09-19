# ZVAlertController
a custom swift alert controller

![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)[](https://github.com/Carthage/Carthage)
![CocoaPods Compatible](https://img.shields.io/badge/pod-1.0.0-4BC51D.svg?style=flat)[](https://cocoapods.org)
![Platform](https://img.shields.io/badge/platform-ios-9F9F9F.svg)[](http://cocoadocs.org/docsets/Alamofire)


ZVAlertController is a pure-swift and wieldy AlertController.

## Requirements

- iOS 9.0+ 
- Swift 5.0


## Installation
### Cocoapod
[CocoaPods](https://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects.

You can install Cocoapod with the following command

```
$ sudo gem install cocoapods
```
To integrate `ZVAlertController` into your project using CocoaPods, specify it into your `Podfile`

```
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '8.0'

target 'TargetName' do
    use_frameworks!
    pod 'ZVAlertController'
end
```

Then，install your dependencies with [CocoaPods](https://cocoapods.org).

```
$ pod install
```
### Carthage 

[Carthage](https://github.com/Carthage/Carthage) is intended to be the simplest way to add frameworks to your application.

You can install Carthage with [Homebrew](https://brew.sh) using following command:

```
$ brew update
$ brew install carthage
```

To integrate `ZVAlertController` into your project using Carthage, specify it into your `Cartfile`

```
github "zevwings/ZVAlertController" ~> 0.0.1
```

Then，build the framework with Carthage
using `carthage update` and drag `ZVAlertController.framework` into your project.

#### Note:
The framework is under the Carthage/Build, and you should drag it into  `Target` -> `Genral` -> `Embedded Binaries`

## Usage
You can use `import ZVAlertController` when you needed to use `ZVAlertController`.


### Showing a Alert

When you start a task, You can using following code:

```swift
let alertController = AlertController(title: "title", message: "message")
present(alertController, animated: true, completion: nil)
```

you can add alert action use:

```swift
alertController.addAction(WSAlertAction(title: "confirm", style: .default, handler: { _ in
    print("comfirm action")
}))
```

you can also use `NSAttributedString` in message body

```swift
let attributedString = NSMutableAttributedString(string: "message")
attributedString.addAttributes([.foregroundColor: UIColor.cyan], range: NSRange(location: 0, length: 4))
let alertController = AlertController(title: "title", message: attributedString)
```

### Props
the following props can custom the alertController.

```swift
// dismiss completion handler
public var dismissHandler: DismissHandler?
// should show the dissmiss button 
public var shouldShowDismissButton: Bool = true

// dismiss button content color
public var tintColor: UIColor = .blue

// destructive and default button text color
public var positiveColor: UIColor = Constant.positiveColor
// cancel button text color
public var negativeColor: UIColor = Constant.negativeColor
// action button text font
public var buttonFont: UIFont = .systemFont(ofSize: 14.0)

// title text color 
public var titleColor: UIColor = Constant.titleColor
// title text color 
public var titleFont: UIFont = .systemFont(ofSize: 14.0)

// message body text color 
public var messageColor: UIColor = Constant.messageColor
// message body text font
public var messageFont: UIFont = .systemFont(ofSize: 14.0)
```

### Animation
`ZVAlertController` also provide `AlertPresentStyle` and `AlertDismissStyle` for animation, you can use `presentStyle` or `dismissStyle` to set the showing or hidden animation.

```swift
alertController.presentStyle = .fadeIn
alertController.dismissStyle = .fadeOut
```
More animation you can find in the [Exmaple](https://github.com/zevwings/ZVAlertController/blob/master/ZVAlertControllerExample/ViewController.swift)

# License
`WSAlertAction` distributed under the terms and conditions of the [Apache License](https://github.com/zevwings/ZVAlertController/blob/master/LICENSE)
