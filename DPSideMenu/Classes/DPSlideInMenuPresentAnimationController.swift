//
//  DPSlideInMenuPresentAnimationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 12/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

class DPSlideInMenuPresentAnimationController: DPSlideInMenuBaseAnimationController {
    
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // toVC is the one being presented
        guard let presentedVC = transitionContext.viewController(forKey: .to) else {
            transitionContext.completeTransition(false)
            return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(presentedVC.view)
        
        let finalFrame = transitionContext.finalFrame(for: presentedVC)
        var transform = CGAffineTransform.identity
        switch direction {
        case .topToBottom:
            transform = CGAffineTransform(translationX: 0, y: -finalFrame.height)
        case .leftToRight:
            transform = CGAffineTransform(translationX: -finalFrame.width, y: 0)
        case .bottomToTop:
            transform = CGAffineTransform(translationX: 0, y: containerView.frame.height)
        case .rightToLeft:
            transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        }
        presentedVC.view.transform = transform
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        presentedVC.view.transform = .identity
        }) { (isFinished) in
            transitionContext.completeTransition(isFinished)
        }
        
    }
}
