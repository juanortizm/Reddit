//
//  RedditBaseViewController.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import UIKit

class RedditBaseViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = .white
    }
    
    func showSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func hideSpinner() {
        DispatchQueue.main.async {
            self.spinner.removeFromSuperview()
        }
    }
    
    func showAlert(title: String?) {
        let alert = UIAlertController(title: title ?? "", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
