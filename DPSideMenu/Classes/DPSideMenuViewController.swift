//
//  DPSideMenuViewController.swift
//  DPSideMenu
//
//  Created by Xueqiang Ma on 15/11/18.
//

import UIKit

open class DPSideMenuViewController: UIViewController {
    
    public var headerView: DPSideMenuHeaderView!
    public var tableView: UITableView!
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        setupHeaderView()
        setupTableView()
    }
    
    open func setupHeaderView() {
        headerView = DPSideMenuHeaderView(frame: .zero)
        view.addSubview(headerView)
        headerView.setTitle(title: "More")
        headerView.backgroundColor = .white
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
    fileprivate func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        view.addSubview(tableView)
        if let newSelf = self as? UITableViewDelegate {
            tableView.delegate = newSelf
        }
        if let newSelf = self as? UITableViewDataSource {
            tableView.dataSource = newSelf
        }
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
    }
    
}
