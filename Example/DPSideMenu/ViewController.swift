//
//  ViewController.swift
//  MenuProj
//
//  Created by Xueqiang Ma on 12/11/18.
//  Copyright © 2018 Daniel Ma. All rights reserved.
//

import UIKit
import DPSideMenu

class ViewController: UIViewController {
    
    lazy var slideInTransitioningDelegate = DPSlideInMenuPresentationManager()
    
    fileprivate let menuBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Menu", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        view.addSubview(menuBtn)
        NSLayoutConstraint.activate([
            menuBtn.widthAnchor.constraint(equalToConstant: 80),
            menuBtn.heightAnchor.constraint(equalToConstant: 40),
            menuBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            menuBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        menuBtn.addTarget(self, action: #selector(didTapMenuBtn(_:)), for: .touchUpInside)
    }
    
    @objc func didTapMenuBtn(_ sender: UIButton) {
        let menuController = MenuViewController()
        slideInTransitioningDelegate.direction = .leftToRight
        menuController.transitioningDelegate = slideInTransitioningDelegate
        menuController.modalPresentationStyle = .custom
        present(menuController, animated: true, completion: nil)
    }
    
}

