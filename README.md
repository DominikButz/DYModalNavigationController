# DYModalNavigationController

[![Version](https://img.shields.io/cocoapods/v/DYModalNavigationController.svg?style=flat)](http://cocoapods.org/pods/DYBadge)
[![License](https://img.shields.io/cocoapods/l/DYBadge.svg?style=flat)](http://cocoapods.org/pods/DYBadge)DYModalNavigationController
[![Platform](https://img.shields.io/cocoapods/p/DYModalNavigationController.svg?style=flat)](http://cocoapods.org/pods/DYModalNavigationController)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)


 DYModalNavigationController is a simple UINavigationController subclass written in Swift 5.0. Use cases:
 * present a small size view controller with rounded edges over the current context modally (e.g. if the content is rather small and the standard modal presentation would show a lot of empty space). Set a fixed size so that the navigation controller's size is not adjusted when the screen orientation changes. 
 *  present a modal view controller over the current context with top, bottom, left, right margins with a fade in transition. The presenting view controller behind it is still visible at the margins (unless margins set to 0). The size adjusts automatically when the screen orientation changes.

## Example

To checkout the example project, simply clone the repo or download the zip file. 

## Features

* Create a DYModalNavigationController with a fixed size in case your view controller instance should not change its size when changing the screen orientation.
* Set a background blur or dim effect
* Customise the corner radius of the DYModalNavigationController view.
* Set a slide in/out animation (customisable animation movement directions) or a fade in/out animation
* Customise the drop shadow
* Customise the animation transition duration

## Installation


Installation through Cocoapods or Carthage is recommended. 

Cocoapods:

target '[project name]' do
 	pod 'DYModalNavigationController', '~> 1.0
end

Carthage: Simply add the following line to your Cartfile.

github "DominikButz/DYModalNavigationController" ~> 1.0

Check out the version history below for the current version.

Afterwards, run "carthage update DYModalNavigationController --platform iOS" in the root directory of your project. Follow the steps described in the carthage project on github (click on the carthage compatible shield above). 

Make sure to import DYModalNavigationController into your View Controller subclass:

```Swift
import DYModalNavigationController
```

## Usage

Check out the following examples. 

### Code example: Fixed size DYModalNavigationController with background blur


```Swift

 override func viewDidLoad() {
   super.viewDidLoad()
   

        let size = CGSize(width: 300, height: 200)
        var settings = DYModalNavigationControllerSettings()
  			settings.slideInDirection = .right
        settings.slideOutDirection = .right
        settings.backgroundEffect = .blur
        self.navController = DYModalNavigationController(rootViewController: contentVC(), fixedSize: size, settings: settings)
  
   
 }

```

![DYModalNavigationController example](./gitResources/DYModalNavigationController1-small.gif "DYModalNavigationController example 1") 

### Code example: DYModalNavigationController with margins and fade effect 

 
```Swift

 override func viewDidLoad() {
	    super.viewDidLoad()
	
        var settings = DYModalNavigationControllerSettings()
  			settings.animationType  = .fadeInOut
  			// background effect .none is default setting!
        self.navController = DYModalNavigationController(rootViewController: contentVC(), fixedSize: nil, settings: settings)
        // with fixedSize nil, the size will be set according to the top, bottom, left, right margins in the settings. 
	}
```
![DYModalNavigationController example](./gitResources/DYModalNavigationController2-small.gif "DYModalNavigationController example 2") 


## Change log
#### [Version 1.0](https://github.com/DominikButz/DYBadge/releases/tag/1.0)
initial version.


## Author

dominikbutz@gmail.com

## License

DYModalNavigationController is available under the MIT license. See the LICENSE file for more info.

