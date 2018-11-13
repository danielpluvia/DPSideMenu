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
    
    deinit {
        print("\(self)")
    }
    
    var slideInTransitioningDelegate = DPSlideInMenuPresentationManager()
    
    fileprivate let menuBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Menu", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    fileprivate let dismissBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Dismiss", for: .normal)
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
        menuBtn.addTarget(self, action: #selector(didTapMenuBtn), for: .touchUpInside)
        
        view.addSubview(dismissBtn)
        NSLayoutConstraint.activate([
            dismissBtn.widthAnchor.constraint(equalToConstant: 80),
            dismissBtn.heightAnchor.constraint(equalToConstant: 40),
            dismissBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dismissBtn.topAnchor.constraint(equalTo: menuBtn.bottomAnchor, constant: 100)
            ])
        dismissBtn.addTarget(self, action: #selector(didTapDismissBtn), for: .touchUpInside)
    }
    
    @objc func didTapMenuBtn() {
        let menuController = UIViewController()
        menuController.view.backgroundColor = .white
        menuController.view.translatesAutoresizingMaskIntoConstraints = false
        slideInTransitioningDelegate.direction = .leftToRight
        menuController.transitioningDelegate = slideInTransitioningDelegate
        menuController.modalPresentationStyle = .custom
        present(menuController, animated: true, completion: nil)
    }
    
    @objc func didTapDismissBtn() {
        dismiss(animated: true, completion: nil)
    }
    
}

