//
//  SideMenuPresentationManager.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 13/2/18.
//

import UIKit

public class SideMenuPresentationManager: NSObject {
    public enum PresentationDirection {
        case left   // from left to right
        case right  // from right to left
        case top    // from top to bottom
        case bottom // from bottom to top
    }
    
    var direction: PresentationDirection
    
    fileprivate var sideMenuPresentationController: SideMenuPresentationController! = nil
    
    public init(direction: PresentationDirection) {
        self.direction = direction
        super.init()
    }
    
    //    deinit {
    //        print("SideMenuPresentationManager deinited")
    //    }
}

extension SideMenuPresentationManager: UIViewControllerTransitioningDelegate {
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        self.sideMenuPresentationController = SideMenuPresentationController(presentedViewController: presented,
                                                                             presenting: presenting,
                                                                             direction: self.direction)
        return self.sideMenuPresentationController
    }
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuPresentationAnimator(isPresentation: true,
                                            direction: self.direction)
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SideMenuPresentationAnimator(isPresentation: false,
                                            direction: self.direction)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.sideMenuPresentationController.interactionController
    }
}
