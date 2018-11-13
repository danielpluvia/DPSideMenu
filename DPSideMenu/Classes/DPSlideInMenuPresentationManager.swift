//
//  DPSlideInMenuPresentationManager.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 12/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

public class DPSlideInMenuPresentationManager: NSObject {
    
    public enum PresentationDirection {
        case topToBottom
        case leftToRight
        case bottomToTop
        case rightToLeft
    }
    
    public override init() {
        super.init()
    }
    
    public var direction: PresentationDirection = .leftToRight
    fileprivate weak var interactiveTransition: DPSlideInMenuDismissInteractiveTransition?
    // Warning: MUST NOT holding a strong reference of presentationController here, or it will cause retain cycle. Thus, we use a weak reference of interactiveTransition to point to the real interactiveTransition which is stored in presentationController.
    
}

extension DPSlideInMenuPresentationManager: UIViewControllerTransitioningDelegate {
    
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        let presentationController =  DPSlideInMenuPresentationController(presentedViewController: presented,
                                                   presenting: presenting,
                                                   direction: direction)
        self.interactiveTransition = presentationController.interactiveTransition
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPSlideInMenuPresentAnimationController(direction: .leftToRight)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPSlideInMenuDismissAnimationController(direction: .leftToRight)
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactiveTransition = interactiveTransition else { return nil }
        return interactiveTransition.isInteracting ? interactiveTransition : nil
    }
}
