//
//  RedditSplitViewController.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import UIKit

class RedditSplitViewController: UISplitViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presentsWithGesture = true
        self.delegate = self
    }
}

extension RedditSplitViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
        return true
    }
}
