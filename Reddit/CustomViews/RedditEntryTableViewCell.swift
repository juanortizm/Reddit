//
//  RedditEntryTableViewCell.swift
//  Reddit
//
//  Created by Juan Ortiz on 19/04/2019.
//  Copyright © 2019 Juan Ortiz. All rights reserved.
//

import UIKit

class RedditEntryTableViewCell: UITableViewCell {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var commentsLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var wasSeenContainerView: UIView!
    
    public var didTapDismissBlock: ((_ cell: RedditEntryTableViewCell) -> Void)?
    public let wasSeenIndicatorView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 16))
    private var model: RedditEntryDto?
    
    override func prepareForReuse() {
        self.avatarImageView.image = nil
        self.titleLabel.text = nil
        self.commentsLabel.text = nil
        self.usernameLabel.text = nil
        self.dateLabel.text = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wasSeenContainerView.addSubview(wasSeenIndicatorView)
        wasSeenIndicatorView.layer.masksToBounds = true
        wasSeenIndicatorView.layer.cornerRadius = wasSeenIndicatorView.frame.height / 2
        wasSeenIndicatorView.backgroundColor = .blue
    }
    
    func setup(with model: RedditEntryDto) {
        self.model = model
        
        self.titleLabel.text = model.title
        self.usernameLabel.text = model.author
    }
    
    @IBAction func didTapDismissButton(_ sender: Any) {
        self.didTapDismissBlock?(self)
    }
}
