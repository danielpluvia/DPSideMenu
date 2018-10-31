//
//  DPSideMenuInteractionController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 22/9/18.
//

import UIKit

class DPSideMenuInteractionController: UIPercentDrivenInteractiveTransition {
    var interactionInProgress = false
    
    fileprivate var shouldCompleteTransition = false
    fileprivate weak var viewController: UIViewController!
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
