# Lightsy

[![License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://github.com/fabianehlert/Lightsy/blob/master/LICENSE)
[![Version](https://img.shields.io/badge/version-1.0-green.svg)](https://github.com/fabianehlert/Lightsy)
[![Build Status](https://travis-ci.org/fabianehlert/SpringyPopup.svg?branch=master)](https://travis-ci.org/fabianehlert/Lightsy)
[![Twitter: @fabianehlert](https://img.shields.io/badge/twitter-fabianehlert-blue.svg)](https://twitter.com/fabianehlert)
[![Open Source by Default](https://img.shields.io/badge/Open%20Source-Default-blue.svg)](https://github.com/fabianehlert)

## About
<img src="res/Artwork.png" width="250">
<br><br>
**[Lightsy is available on the App Store](https://appstore.com/lightsy)**

> Because there is nothing like it.

## Here is how it works

### Overview of the colors
As of right now there is now public API from Apple that allows us developers to access the color temperature of a device's screen like Night Shift (introduced in iOS 9.3) does. We can only simulate it by setting the `backgroundColor` of an `UIView` object to a color that comes close the what it would look like in real life. If you want to learn more about it, checkout this site I stumbled upon and found really helpful. It's also the site I took the color values for Lightsy from: [http://planetpixelemporium.com/tutorialpages/light.html](http://planetpixelemporium.com/tutorialpages/light.html)

Here is an excerpt of four of the colors of the entire spectrum Lightsy can display:

![](res/Overview-Colors.jpg)

### How you can interact with Lightsy
It's as simple as sliding your finger vertically on the screen to change the color temperature.

<center>
![](res/Demo.gif)
![](res/Me.gif)
</center>

## Setup
For dependency management, [CocoaPods](https://github.com/CocoaPods/CocoaPods) is being used. As the `Pods` folder is not included, installing [CocoaPods](https://github.com/CocoaPods/CocoaPods) and the dependencies with it is required to run the project.

If you haven't installed it on your system yet, continue with the following steps:

1. `sudo gem install cocoapods`
 - will ask for your password
2. `pod setup`
 - sets up CocoaPods master repository
3. `cd [wherever you cloned Lightsy]/Lightsy`
 - basically `cd` to the folder in which lies the Podfile of Lightsy
4. `pod install`
 - installs dependencies

## Future
- [ ] macOS App

## Author
Fabian Ehlert, [fabian@fabianehlert.com](mailto:fabian@fabianehlert.com)

## License
Lightsy is available under the MIT license. See the LICENSE file for more info.
