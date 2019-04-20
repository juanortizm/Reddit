//
//  RedditEntryDetailViewController.swift
//  Reddit
//
//  Created by Juan Ortiz on 20/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

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
    
    // didTapAvatarImageView: save image in photos gallery
    @IBAction func didTapAvatarImageView(_ sender: Any) {
        guard let image = self.avatarImageView.image else { return }
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    // didTapPosts: open a new view controller with the post label
    @IBAction func didTapPosts(_ sender: Any) {
        let postViewController = RedditBaseViewController()
        let postNavigationController = UINavigationController(rootViewController: postViewController)
        let postsLabel: UILabel = UILabel(frame: titleLabel.frame)
        postsLabel.numberOfLines = 0
        postsLabel.text = model?.title
        postViewController.view.backgroundColor = .white
        postViewController.view.addSubview(postsLabel)
        postViewController.title = "Tap view to dismiss"
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapPostsView))
        postViewController.view.addGestureRecognizer(tap)
        self.splitViewController?.present(postNavigationController, animated: true, completion: {
            postsLabel.center = postViewController.view.center
        })
    }
    
    @objc private func image(_ image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: UnsafeRawPointer) {
        if ((error) != nil) {
            self.showAlert(title: "Error saving image")
        } else {
            self.showAlert(title: "The image has been saved!")
        }
    }
    
    @objc private func didTapPostsView() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RedditEntryDetailViewController {
    
    
}
