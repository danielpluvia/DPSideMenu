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
    
    deinit {
        print("\(self)")
    }
    
    public var direction: PresentationDirection = .leftToRight
    var presentationController: DPSlideInMenuPresentationController? = nil  // Hold a reference so that interactionControllerForDismissal(using:) can access interactive transition within the presentationController
    
}

extension DPSlideInMenuPresentationManager: UIViewControllerTransitioningDelegate {

    public func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        presentationController = DPSlideInMenuPresentationController(presentedViewController: presented,
                                                                     presenting: presenting,
                                                                     direction: direction)
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPSlideInMenuPresentAnimationController(direction: .leftToRight)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DPSlideInMenuDismissAnimationController(direction: .leftToRight)
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let interactiveTransition = presentationController?.interactiveTransition else {
            return nil
        }
        return interactiveTransition.isInteracting ? interactiveTransition : nil
    }
}
