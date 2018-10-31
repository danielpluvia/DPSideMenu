//
//  DPSideMenu.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 23/9/18.
//

import UIKit

class DPSideMenu: NSObject, UIViewControllerTransitioningDelegate {
  
  let duration = 0.5
  
  func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return DPSideMenuPresentAnimationController(duration: self.duration)
  }
  
  func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    return DPSideMenuDismissAnimationController(duration: self.duration)
  }
}
