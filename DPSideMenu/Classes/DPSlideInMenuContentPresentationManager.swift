//
//  DPSlideInMenuContentPresentationManager.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 15/11/18.
//

import UIKit

public class DPSlideInMenuContentPresentationManager: NSObject {
    
    public enum PresentationDirection {
        case topToBottom
        case leftToRight
        case bottomToTop
        case rightToLeft
    }
    
    fileprivate var duration: TimeInterval = 0.2
    fileprivate var direction: PresentationDirection = .rightToLeft
    
    public override init() {
        super.init()
    }
    
    public func setup(viewController: UIViewController,
                      duration: TimeInterval = 0.2,
                      direction: PresentationDirection = .rightToLeft) {
        viewController.transitioningDelegate = self
        viewController.modalPresentationStyle = .custom
        self.duration = duration
        self.direction = direction
    }
    
}

extension DPSlideInMenuContentPresentationManager: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        return nil
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPSlideInMenuContentPresentAnimationController(duration: duration)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPSlideInMenuContentDismissAnimationController(duration: duration)
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
}
