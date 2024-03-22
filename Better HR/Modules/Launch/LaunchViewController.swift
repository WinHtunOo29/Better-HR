//
//  LaunchViewController.swift
//  Better HR
//
//  Created by Win Htun Oo on 19/03/2024.
//

import Foundation
import UIKit
import NVActivityIndicatorView

class LaunchViewController: UIViewController {
    let window: UIWindow? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
    let activityIndicatorView = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), type: .lineScale, color: .systemTeal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(activityIndicatorView)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        activityIndicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2), execute: {
            let listingViewController = ListingRouter.createModule()
            let nav = UINavigationController(rootViewController: listingViewController)
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
            self.activityIndicatorView.stopAnimating()
        })
    }
}
