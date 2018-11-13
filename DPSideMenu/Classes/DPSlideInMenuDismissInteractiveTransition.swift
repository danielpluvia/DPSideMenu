//
//  DPSlideInMenuDismissInteractiveTransition.swift
//  This class is responsible for the dismissing interactive transition.
//  DPSideMenu
//
//  Created by Xueqiang Ma on 13/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

extension DPSlideInMenuDismissInteractiveTransition {
    /// The gesture should move within the slidewindow. If the gestuer exceeds the range of the slidewindow, the slidewindow would move to the new position to ensure the gesture is always in the range.
    fileprivate struct SlideWindow {
        var start: CGFloat
        var end: CGFloat
        var length: CGFloat {
            return end - start
        }
        
        init(start: CGFloat, end: CGFloat) {
            self.start = start
            self.end = end
        }
        
        mutating func reset() {
            start = 0
            end = 0
        }
        
        mutating func set(start: CGFloat, end: CGFloat) {
            self.start = start
            self.end = end
        }
        
        mutating func scroll(diff: CGFloat) {
            self.start += diff
            self.end += diff
        }
    }
}

class DPSlideInMenuDismissInteractiveTransition: UIPercentDrivenInteractiveTransition {
    deinit {
        print("\(self)")
    }
    var isInteracting: Bool = false
    weak var presentedVC: UIViewController?   // This is the menuVC
    fileprivate var direction: DPSlideInMenuPresentationManager.PresentationDirection   // refers to how the menu opened
    fileprivate var slideWindow: DPSlideInMenuDismissInteractiveTransition.SlideWindow = SlideWindow(start: 0, end: 0 )
    fileprivate let velocityThreshold: CGFloat = 500
    fileprivate var progress: CGFloat = 0
    
    init(presentedVC: UIViewController, direction: DPSlideInMenuPresentationManager.PresentationDirection) {
        self.presentedVC = presentedVC
        self.direction = direction
        super.init()
    }
    
    func addGesture(to view: UIView) {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        guard let presentedFrame = presentedVC?.view.frame else {return}
        switch gesture.state {
        case .began:
            isInteracting = true
            progress = 0
            switch direction {  // Set slidewindow's range equals to the menuwidth.
            case .topToBottom, .bottomToTop:
                slideWindow.set(start: 0, end: presentedFrame.height)
            case .leftToRight, .rightToLeft:
                slideWindow.set(start: 0, end: presentedFrame.width)
            }
            presentedVC?.dismiss(animated: true, completion: nil)
        case .changed:
            guard let containerView = gesture.view else {return}
            let translation = gesture.translation(in: containerView)
            var translationOnAxis: CGFloat = 0  // refers to the direction and how long the gesture has moved.
            switch direction {
            case .topToBottom:
                translationOnAxis = translation.y
                guard translationOnAxis >= 0 else { return }
            case .leftToRight:
                translationOnAxis = translation.x
                guard translationOnAxis <= 0 else { return }
            case .bottomToTop:
                translationOnAxis = translation.y
                guard translationOnAxis <= 0 else { return }
            case .rightToLeft:
                translationOnAxis = translation.x
                guard translationOnAxis >= 0 else { return }
            }
            translationOnAxis = abs(translationOnAxis)
            let velocity = gesture.velocity(in: containerView)
            switch direction {
            case .topToBottom, .leftToRight:
                if velocity.x < 0 { // closing menu
                    slideWindow.scroll(diff: max(0, translationOnAxis - slideWindow.end))  // Slide the window if the gesture exceeds the window's range
                } else {    // opening menu
                    slideWindow.scroll(diff: -max(0, slideWindow.start - translationOnAxis))
                }
            case .bottomToTop, .rightToLeft:
                if velocity.x < 0 { // opening menu
                    slideWindow.scroll(diff: -max(0, slideWindow.start - translationOnAxis))
                } else {    // closing menu
                    slideWindow.scroll(diff: max(0, translationOnAxis - slideWindow.end))
                }
            }
            let menuDistance = translationOnAxis - slideWindow.start
            progress = menuDistance / slideWindow.length
            update(progress)
        case .cancelled:
            isInteracting = false
            cancel()
            progress = 0
        case .ended:
            isInteracting = false
            handleEnded(gesture: gesture)
        default:
            break
        }
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let velocity = gesture.velocity(in: gesture.view!)
        switch direction {
        case .leftToRight:
            if velocity.x < -velocityThreshold {
                finish()
                return
            }
        default:
            break
        }
        if progress < 0.4 {
            if progress < 0.1 {
                completionSpeed = 0.05  // slow the animation down
            } else {
                completionSpeed = 0.12  // slow the animation down
            }
            cancel()
        } else {
            finish()
        }
        progress = 1
    }
    
    override func cancel() {
        
        super.cancel()
    }
    
    override func finish() {
        completionSpeed = 0.3  // slow the animation down
        super.finish()
    }
}
