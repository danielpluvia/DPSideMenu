//
//  SideMenuPresentationController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 13/2/18.
//

import UIKit

class SideMenuPresentationController: UIPresentationController {
    var dimmingView: UIView = UIView()
    var direction: SideMenuPresentationManager.PresentationDirection = .left
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        if let containerSize = self.containerView?.bounds.size {
            frame.size = size(forChildContentContainer: self.presentedViewController,
                              withParentContainerSize: containerSize)
            switch direction {
            case .right:
                frame.origin.x = containerSize.width - frame.width
            case .bottom:
                frame.origin.y = containerSize.height - frame.height
            default:
                break
            }
        }
        return frame
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.setupDimmingView()
    }
}

fileprivate extension SideMenuPresentationController {
    func setupDimmingView() {
        self.dimmingView.removeFromSuperview()
        self.dimmingView = UIView()
        self.dimmingView.translatesAutoresizingMaskIntoConstraints = false
        self.dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 1.0)
        self.dimmingView.alpha = 0.0
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        self.dimmingView.addGestureRecognizer(recognizer)
    }
    
    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        self.presentedViewController.dismiss(animated: true) {
            
        }
    }
}

extension SideMenuPresentationController {
    override func presentationTransitionWillBegin() {
        guard let containerView = self.containerView else { return }
        containerView.insertSubview(self.dimmingView, at: 0)
        if #available(iOS 9.0, *) {
            self.dimmingView.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            self.dimmingView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
            self.dimmingView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
            self.dimmingView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        } else {
            // Fallback on earlier versions
        }
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 0.5
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.5
        })
        
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
        
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = self.presentedViewController.transitionCoordinator else {
            self.dimmingView.alpha = 0.0
            return
        }
        coordinator.animate(alongsideTransition: { (_) in
            self.dimmingView.alpha = 0.0
        })
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        
        return CGSize(width: parentSize.width * (2.0 / 3.0), height: parentSize.height)
    }
}
