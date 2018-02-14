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
    
    //    deinit {
    //        print("SideMenuPresentationAnimator: deinited")
    //    }
}

extension SideMenuPresentationAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return self.duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let key = isPresentation ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from
        guard let controller = transitionContext.viewController(forKey: key), let view = controller.view else { return }
        transitionContext.containerView.addSubview(view)
        let containerView = transitionContext.containerView
        let presentedFrame = transitionContext.finalFrame(for: controller)                      // The frame of presentedView that presented finally,
                                                                                                //      equals to frameOfPresentedViewInContainerView in SideMenuPresentationController
        var dismissedFrame = presentedFrame                                                     // The frame of presentedView after dismissed
        switch direction {
        case .top:
            dismissedFrame.origin.y = containerView.frame.origin.y - presentedFrame.size.height
            dismissedFrame.origin.x = containerView.frame.origin.x
        case .bottom:
            dismissedFrame.origin.y = containerView.frame.size.height
            dismissedFrame.origin.x = containerView.frame.origin.x
        case .left:
            dismissedFrame.origin.x = containerView.frame.origin.x - presentedFrame.size.width
            dismissedFrame.origin.y = containerView.frame.origin.y
        case .right:
            dismissedFrame.origin.x = containerView.frame.size.width
            dismissedFrame.origin.y = containerView.frame.origin.y
        }
        var initialFrame = presentedFrame
        var finalFrame = presentedFrame
        var options: UIViewAnimationOptions = []
        if isPresentation {
            initialFrame = dismissedFrame
            finalFrame = presentedFrame
            options = [.curveEaseIn]
        } else {
            initialFrame = presentedFrame
            finalFrame = dismissedFrame
            options = [.curveEaseOut]
        }
        view.frame = initialFrame
        UIView.animate(withDuration: self.duration,
                       delay: 0.0,
                       options: options,
                       animations: {
                        view.frame = finalFrame
        },
                       completion: { (finished) in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
