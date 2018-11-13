# DPSideMenu: Side Menu for Swift

[![CI Status](http://img.shields.io/travis/danielpluvia/DPSideMenu.svg?style=flat)](https://travis-ci.org/danielpluvia/DPSideMenu)
[![Version](https://img.shields.io/cocoapods/v/DPSideMenu.svg?style=flat)](http://cocoapods.org/pods/DPSideMenu)
[![License](https://img.shields.io/cocoapods/l/DPSideMenu.svg?style=flat)](http://cocoapods.org/pods/DPSideMenu)
[![Platform](https://img.shields.io/cocoapods/p/DPSideMenu.svg?style=flat)](http://cocoapods.org/pods/DPSideMenu)

## Note

The most tricky part is how to store the reference of `interactiveTransition` and pass it to `interactionControllerForDismissal(:)` method.

You MUST NOT store a strong reference of `presentationController` in the `UIViewControllerTransitioningDelegate` class, or it will cause a problem of retain cycle. Thus, we use a weak reference of `interactiveTransition` to point to the real interactiveTransition which is stored in `presentationController`.

Here is the deinit order:

```
<DPSideMenu.DPSlideInMenuPresentAnimationController: 0x2805103c0>
<DPSideMenu.DPSlideInMenuDismissAnimationController: 0x2805040c0>
<DPSideMenu.DPSlideInMenuPresentationController: 0x153e00b30>
<DPSideMenu.DPSlideInMenuDismissInteractiveTransition: 0x2837338d0>
<DPSideMenu_Example.MenuViewController: 0x153e00600>
<DPSideMenu_Example.ViewController: 0x153900900>
<DPSideMenu.DPSlideInMenuPresentationManager: 0x280529440>
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

DPSideMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'DPSideMenu'
```

## Usage

```swift
import DPSideMenu
class ViewController: UIViewController {

lazy var slideInTransitioningDelegate = DPSlideInMenuPresentationManager()

@objc func didTapMenuBtn() {
    let menuController = MenuViewController()
    slideInTransitioningDelegate.direction = .leftToRight
    menuController.transitioningDelegate = slideInTransitioningDelegate
    menuController.modalPresentationStyle = .custom
    present(menuController, animated: true, completion: nil)
}

}
```

## Author

Daniel Ma

## License

DPSideMenu is available under the MIT license. See the LICENSE file for more info.
