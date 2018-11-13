//
//  DPSlideInMenuBaseAnimationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 12/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

class DPSlideInMenuBaseAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    deinit {
        print("\(self)")
    }
    let duration = 0.3
    var direction: DPSlideInMenuPresentationManager.PresentationDirection
    
    init(direction: DPSlideInMenuPresentationManager.PresentationDirection) {
        self.direction = direction
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // To be override by subclass
    }
    
}
