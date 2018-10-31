//
//  DPSideMenuDismissAnimationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 23/9/18.
//

import UIKit

class DPSideMenuDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
//  fileprivate let destinationFrame: CGRect
  fileprivate var duration: TimeInterval
  
  init(duration: TimeInterval) {
    self.duration = duration
  }
  
  func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return duration
  }
  
  func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard let fromVC = transitionContext.viewController(forKey: .from),
      let toVC = transitionContext.viewController(forKey: .to),
      let snapshot = fromVC.view.snapshotView(afterScreenUpdates: false) else {
        return
    }
    
    snapshot.layer.masksToBounds = true
    
    let containerView = transitionContext.containerView
    containerView.insertSubview(toVC.view, at: 0)
    containerView.addSubview(snapshot)
    fromVC.view.isHidden = true
  }
  
}
