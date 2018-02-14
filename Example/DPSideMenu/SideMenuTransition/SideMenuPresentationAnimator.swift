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
    fileprivate let duration: TimeInterval = 0.6
    
    init(isPresentation: Bool, direction: SideMenuPresentationManager.PresentationDirection) {
        self.isPresentation = isPresentation
        self.direction = direction
        super.init()
    }
    
    deinit {
        //        print("SideMenuPresentationAnimator: deinited")
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
            let finialFrame = presentedFrame
            switch direction {
            case .top:
                initialFrame.origin.y = containerView.frame.origin.y - presentedFrame.size.height
                initialFrame.origin.x = containerView.frame.origin.x
            case .bottom:
                initialFrame.origin.y = containerView.frame.size.height + presentedFrame.size.height
                initialFrame.origin.x = containerView.frame.origin.x
            case .left:
                initialFrame.origin.x = containerView.frame.origin.x - presentedFrame.size.width
                initialFrame.origin.y = containerView.frame.origin.y
            case .right:
                initialFrame.origin.x = containerView.frame.size.width + presentedFrame.size.width
                initialFrame.origin.y = containerView.frame.origin.y
            }
            transitionContext.containerView.addSubview(presentedView)
            presentedView.frame = initialFrame
            UIView.animate(withDuration: self.duration,
                           delay: 0.0,
                           usingSpringWithDamping: 0.0,
                           initialSpringVelocity: 0.0,
                           options: [.curveEaseInOut],
                           animations: {
                            presentedView.frame = finialFrame
            },
                           completion: { (finished) in
                            transitionContext.completeTransition(finished)
            })
        } else {
            guard let dismissedViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from), let dismissedView = dismissedViewController.view else { return }
            let containerView = transitionContext.containerView
            let dismissedFrame = transitionContext.finalFrame(for: dismissedViewController)
            let initialFrame = dismissedFrame
            var finialFrame = dismissedFrame
            switch direction {
            case .top:
                finialFrame.origin.y = containerView.frame.origin.y - dismissedFrame.size.height
                finialFrame.origin.x = dismissedFrame.origin.x
            case .bottom:
                finialFrame.origin.y = containerView.frame.size.height + dismissedFrame.size.height
                finialFrame.origin.x = dismissedFrame.origin.x
            case .left:
                finialFrame.origin.x = containerView.frame.origin.x - dismissedFrame.size.width
                finialFrame.origin.y = dismissedFrame.origin.y
            case .right:
                finialFrame.origin.x = containerView.frame.size.width + dismissedFrame.size.width
                finialFrame.origin.y = dismissedFrame.origin.y
            }
            dismissedView.frame = initialFrame
            UIView.animate(withDuration: self.duration,
                           delay: 0.0,
                           usingSpringWithDamping: 0.0,
                           initialSpringVelocity: 0.0,
                           options: [.curveEaseInOut],
                           animations: {
                            dismissedView.frame = finialFrame
            },
                           completion: { (finished) in
                            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
    }
}
