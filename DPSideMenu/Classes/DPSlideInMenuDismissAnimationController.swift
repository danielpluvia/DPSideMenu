//
//  DPSlideInMenuDismissAnimationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 12/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

class DPSlideInMenuDismissAnimationController: DPSlideInMenuBaseAnimationController {
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // fromVC is the one being dismissed
        guard let presentedVC = transitionContext.viewController(forKey: .from) else {
            transitionContext.completeTransition(false)
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(presentedVC.view)
        
        let initialFrame = transitionContext.finalFrame(for: presentedVC)
        var transform = CGAffineTransform.identity
        switch direction {
        case .topToBottom:
            transform = CGAffineTransform(translationX: 0, y: -initialFrame.height)
        case .leftToRight:
            transform = CGAffineTransform(translationX: -initialFrame.width, y: 0)
        case .bottomToTop:
            transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)
        case .rightToLeft:
            transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        }
        presentedVC.view.transform = .identity
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        presentedVC.view.transform = transform
        }) { (isFinished) in
            transitionContext.completeTransition(isFinished && !transitionContext.transitionWasCancelled)
        }
    }
}
