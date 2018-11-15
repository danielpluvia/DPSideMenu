//
//  DPSlideInPresentationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 12/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit

class DPSlideInMenuPresentationController: UIPresentationController {

    fileprivate var direction: DPSlideInMenuPresentationManager.PresentationDirection
    var interactiveTransition: DPSlideInMenuDismissInteractiveTransition?
    /// Set final frame's size and position
    override public var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)
        switch direction {
        case .rightToLeft:
            frame.origin.x = containerView!.frame.width - frame.width
        case .bottomToTop:
            frame.origin.y = containerView!.frame.height - frame.height
        default:
            break
        }
        return frame
    }
    
    fileprivate lazy var dimmingView: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = UIColor(white: 0, alpha: 0.5)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapDimmingView(_:)))
        v.addGestureRecognizer(tapGesture)
        return v
    }()
    
    init(presentedViewController: UIViewController,
         presenting presentingViewController: UIViewController?,
         direction: DPSlideInMenuPresentationManager.PresentationDirection) {
        self.direction = direction
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        interactiveTransition = DPSlideInMenuDismissInteractiveTransition(presentedVC: presentedViewController, direction: direction)
    }
    
    @objc func didTapDimmingView(_ recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
    
}

extension DPSlideInMenuPresentationController {
    
    override func presentationTransitionWillBegin() {
        guard let containerView = containerView, let coordinator = presentedViewController.transitionCoordinator else {return}
        
        // Add dimmingView into the containerView and palce it beyond the presenting view and below the presented view
        containerView.addSubview(dimmingView)
        NSLayoutConstraint.activate([
            dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor),
            dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor)
            ])
        dimmingView.alpha = 0
        
        coordinator.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 1
        }, completion: nil)
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        guard completed, let containerView = containerView else {
            dimmingView.removeFromSuperview()
            return
        }
        interactiveTransition?.attachGesture(to: containerView)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {return}
        coordinator.animate(alongsideTransition: { (context) in
            self.dimmingView.alpha = 0
        }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        guard completed else {
            dimmingView.alpha = 1
            return
        }
        dimmingView.removeFromSuperview()
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        switch direction {
        case .leftToRight, .rightToLeft:
            return CGSize(width: min(parentSize.width * 2.0 / 3.0, 300), height: parentSize.height)
        case .topToBottom, .bottomToTop:
            return CGSize(width: parentSize.width, height: min(parentSize.height * 2.0 / 3.0, 300))
        }
    }
    
}
