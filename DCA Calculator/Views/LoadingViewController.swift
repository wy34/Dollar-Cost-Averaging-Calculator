//
//  LoadingViewController.swift
//  DCA Calculator
//
//  Created by William Yeung on 4/6/21.
//

import UIKit

class LoadingViewController: UIViewController {
    // MARK: - Views
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        return spinner
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Helpers
    func showLoader() {
        view.addSubview(spinner)
        spinner.center(x: view.centerXAnchor, y: view.centerYAnchor)
    }
    
    func dismissLoader() {
        spinner.removeFromSuperview()
    }
}
