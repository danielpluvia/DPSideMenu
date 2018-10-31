//
//  DPSideMenuPresentAnimationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 22/9/18.
//

import UIKit

class DPSideMenuPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
  
//  fileprivate let originFrame: CGRect
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
      let snapshot  = toVC.view.snapshotView(afterScreenUpdates: true) else {
        return
    }
    
    let containView = transitionContext.containerView
    let finalFrame = transitionContext.finalFrame(for: toVC)
    
//    snapshot.frame = self.originFrame
    
    containView.addSubview(toVC.view)
    containView.addSubview(snapshot)
    toVC.view.isHidden = true
  }
  
}
