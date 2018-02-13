//
//  SideMenuPresentationManager.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 13/2/18.
//

import UIKit

public class SideMenuPresentationManager: NSObject {
    enum PresentationDirection {
        case left   // from left to right
        case right  // from right to left
        case top    // from top to bottom
        case bottom // from bottom to top
    }
    
    var direction: PresentationDirection = .left
    
}

extension SideMenuPresentationManager: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let presentationController = SideMenuPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationController
    }
    
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuPresentationAnimator(isPresentation: true, direction: self.direction)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuPresentationAnimator(isPresentation: false, direction: self.direction)
    }
}
