//
//  SideMenuPresentationController.swift
//  DPSideMenu
//
//  This class is for managing the dimming view, resizing the presented view and
//  determing the final frame of the presented view.
//
//  Created by Xueqiang Ma on 13/2/18.
//

import UIKit

class SideMenuPresentationController: UIPresentationController {
    var dimmingView: UIView = UIView()
    var direction: SideMenuPresentationManager.PresentationDirection
    var interactionController: UIPercentDrivenInteractiveTransition?
    
    // Position of the presented view in the container view by the end of the presentation transition.
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
    
    init(presentedViewController: UIViewController,
                  presenting presentingViewController: UIViewController?,
                  direction: SideMenuPresentationManager.PresentationDirection) {
        self.direction = direction
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        self.setupDimmingView()
    }
    
    //    deinit {
    //        print("SideMenuPresentationController: deinited")
    //    }
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

fileprivate extension SideMenuPresentationController {
    func addDismissGesture(to view: UIView) {
        self.interactionController = UIPercentDrivenInteractiveTransition()
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc
    dynamic func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        guard let interactionController = self.interactionController else {return}
        let translate = recognizer.translation(in: recognizer.view)
        var percent: CGFloat = interactionController.percentComplete
        switch self.direction {
        case .top:
            percent = translate.y / recognizer.view!.bounds.size.height
            if percent > 0.0 {
                percent = fmin(percent, interactionController.percentComplete)
            } else {
                percent = percent.magnitude
            }
        case .bottom:
            percent = translate.y / recognizer.view!.bounds.size.height
            if percent < 0.0 {
                percent = fmin(percent.magnitude, interactionController.percentComplete)
            }
        case .left:
            percent = translate.x / recognizer.view!.bounds.size.width
            if percent > 0.0 {
                percent = fmin(percent, interactionController.percentComplete)
            } else {
                percent = percent.magnitude
            }
        case .right:
            percent = translate.x / recognizer.view!.bounds.size.width
            if percent < 0.0 {
                percent = fmin(percent.magnitude, interactionController.percentComplete)
            }
        }
        
        switch recognizer.state {
        case .began:
            self.presentedViewController.dismiss(animated: true, completion: nil)
        case .changed:
            if interactionController.percentComplete > 0.6 {
                recognizer.isEnabled = false
            } else {
                interactionController.update(percent)
            }
        case .ended, .cancelled:
            recognizer.isEnabled = true
            if interactionController.percentComplete > 0.25 {
                interactionController.finish()
            } else {
                interactionController.cancel()
            }
        default:
            break
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
        self.addDismissGesture(to: self.presentedView!)
        self.addDismissGesture(to: self.dimmingView)
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
        super.dismissalTransitionDidEnd(completed)
    }
    
    override func size(forChildContentContainer container: UIContentContainer,
                       withParentContainerSize parentSize: CGSize) -> CGSize {
        
        return CGSize(width: parentSize.width * (2.0 / 3.0), height: parentSize.height)
    }
}
