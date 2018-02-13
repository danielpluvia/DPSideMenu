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
    
    lazy var sideMenuTransitioningDelegate = SideMenuPresentationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

