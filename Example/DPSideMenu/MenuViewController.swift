//
//  MenuViewController.swift
//  DPSideMenu_Example
//
//  Created by Xueqiang Ma on 13/11/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import DPSideMenu

class MenuViewController: DPSideMenuViewController, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate let cells: [String] = [
        "Following",
        "My Collects",
        "Saved Drafts",
        "-separator-",
        "Shopping Cart",
        "Orders",
        "Coupons",
        "Wish List",
        "Member",
        "-separator-",
        "Help Center",
        "Scan",
        "Settings"
    ]
    
    lazy var contentTransitioningDelegate = DPSlideInMenuContentPresentationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        tableView.register(DPSideMenuItemCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "separatorCellId")
        tableView.separatorStyle = .none
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @objc func didTapBackBtn() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MenuViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if cells[indexPath.row] == "-separator-" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "separatorCellId", for: indexPath)
            let separator = UIView()
            cell.addSubview(separator)
            separator.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                separator.centerXAnchor.constraint(equalTo: cell.centerXAnchor),
                separator.centerYAnchor.constraint(equalTo: cell.centerYAnchor),
                separator.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.85),
                separator.heightAnchor.constraint(equalToConstant: 0.4)
                ])
            separator.backgroundColor = .lightGray
            separator.alpha = 0.2
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? DPSideMenuItemCell else {
                return UITableViewCell()
            }
            cell.set(title: cells[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newVC = UIViewController()
        newVC.view.backgroundColor = .white
        let nav = UINavigationController(rootViewController: newVC)
        let backBtn = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(didTapBackBtn))
        newVC.navigationItem.leftBarButtonItem = backBtn
        contentTransitioningDelegate.setup(viewController: nav)
        present(nav, animated: true, completion: nil)
    }
}
