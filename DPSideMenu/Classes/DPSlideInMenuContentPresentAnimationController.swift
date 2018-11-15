//
//  DPSlideInMenuContentPresentAnimationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 15/11/18.
//

import Foundation

class DPSlideInMenuContentPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval = 0.3
    
    init(duration: TimeInterval) {
        self.duration = duration
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // toVC is the one being presented
        guard let presentingVC = transitionContext.viewController(forKey: .from),
            let presentedVC = transitionContext.viewController(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(presentedVC.view)
        
        presentedVC.view.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        presentingVC.beginAppearanceTransition(true, animated: true)    // call viewWillAppear
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
                        presentedVC.view.transform = .identity
                        presentingVC.view.transform = CGAffineTransform(translationX: -presentingVC.view.frame.width, y: 0)
        }) { (isFinished) in
            transitionContext.completeTransition(isFinished)
            if isFinished {
                presentingVC.endAppearanceTransition()  // viewDidAppear
            }
        }
    }
    
}
