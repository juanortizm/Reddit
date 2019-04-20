//
//  RedditEntryDetailViewController.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import UIKit

import UIKit

class RedditEntryDetailViewController: RedditBaseViewController {
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var model: RedditEntryDto?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
        self.updateViews()
    }
    
    private func setup() {
        self.avatarImageView.isUserInteractionEnabled = true
        self.navigationController?.navigationBar.isHidden = model != nil
    }
    
    private func updateViews() {
        self.authorLabel.text = model?.author
        self.titleLabel.text = model?.title
        
        if let thumbnail = model?.thumbnail {
            self.avatarImageView.setImageFrom(string: thumbnail)
        }
    }
}
