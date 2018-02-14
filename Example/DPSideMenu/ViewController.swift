//
//  ViewController.swift
//  DPSideMenu
//
//  Created by danielpluvia on 02/13/2018.
//  Copyright (c) 2018 Daniel Ma. All rights reserved.
//

import UIKit
import DPSideMenu

class ViewController: UIViewController {
    
    lazy var sideMenuTransitioningDelegate = SideMenuPresentationManager(direction: .right)

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addGesture()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension ViewController {
    func addGesture() {
        let screenEdgeRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(_:)))
        screenEdgeRecognizer.edges = .right
        self.view.addGestureRecognizer(screenEdgeRecognizer)
    }
    
    @objc
    dynamic func handlePanGesture(_ recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            self.performSegue(withIdentifier: "ShowMenuSegue", sender: self)
        }
    }
}

extension ViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMenuSegue" {
            let dest = segue.destination
            dest.transitioningDelegate = self.sideMenuTransitioningDelegate
            dest.modalPresentationStyle = .custom
        }
    }
}

