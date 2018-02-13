//
//  SideMenuPresentationAnimator.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 13/2/18.
//

import UIKit

class SideMenuPresentationAnimator: NSObject {
    var isPresentation: Bool
    var direction: SideMenuPresentationManager.PresentationDirection
    fileprivate let duration: TimeInterval = 0.3
    
    init(isPresentation: Bool, direction: SideMenuPresentationManager.PresentationDirection) {
        self.isPresentation = isPresentation
        self.direction = direction
        super.init()
    }
}

extension SideMenuPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresentation {
            guard let presentedViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to), let presentedView = presentedViewController.view else { return }
            let containerView = transitionContext.containerView
            let presentedFrame = transitionContext.finalFrame(for: presentedViewController)
            var initialFrame = presentedFrame
            var finialFrame = presentedFrame
            switch direction {
            case .top:
                break
            case .bottom:
                break
            case .left:
                initialFrame.origin.x = containerView.frame.origin.x - presentedFrame.size.width
                finialFrame.origin.x = containerView.frame.origin.x
                initialFrame.origin.y = containerView.frame.origin.y
                finialFrame.origin.y = containerView.frame.origin.y
            case .right:
                break
            }
            transitionContext.containerView.addSubview(presentedView)
            presentedView.frame = initialFrame
            UIView.animate(withDuration: self.duration, animations: {
                presentedView.frame = finialFrame
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
        } else {
            guard let dismissedViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let dismissedView = dismissedViewController.view else { return }
            let containerView = transitionContext.containerView
            let dismissedFrame = transitionContext.finalFrame(for: dismissedViewController)
            var initialFrame = dismissedFrame
            var finialFrame = dismissedFrame
            switch direction {
            case .top:
                break
            case .bottom:
                break
            case .left:
                initialFrame.origin.x = dismissedFrame.origin.x
                finialFrame.origin.x = containerView.frame.origin.x - dismissedFrame.size.width
                initialFrame.origin.y = dismissedFrame.origin.y
                finialFrame.origin.y = dismissedFrame.origin.y
            case .right:
                break
            }
            dismissedView.frame = initialFrame
            UIView.animate(withDuration: self.duration, animations: {
                dismissedView.frame = finialFrame
            }, completion: { (finished) in
                transitionContext.completeTransition(finished)
            })
        }
    }
}
