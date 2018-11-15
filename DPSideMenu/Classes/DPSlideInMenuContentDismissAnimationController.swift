//
//  DPSlideInMenuContentDismissAnimationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 15/11/18.
//

import Foundation

class DPSlideInMenuContentDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval = 0.3
    
    init(duration: TimeInterval) {
        self.duration = duration
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // fromVC is the one being dismissed
        guard let presentingVC = transitionContext.viewController(forKey: .to),
            let presentedVC = transitionContext.viewController(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
        }
        let containerView = transitionContext.containerView
        containerView.addSubview(presentedVC.view)
        
        presentedVC.view.transform = .identity
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        presentedVC.view.transform = CGAffineTransform(translationX: containerView.frame.width, y: 0)
                        presentingVC.view.transform = .identity
        }) { (isFinished) in
            transitionContext.completeTransition(isFinished && !transitionContext.transitionWasCancelled)
        }
    }
    
}
