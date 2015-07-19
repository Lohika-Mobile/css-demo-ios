//
//  LikeTableViewCell.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 18.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit
import InstagramKit
import AFNetworking

class LikeTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var fullUserNameLabel: UILabel!
    @IBOutlet private weak var uniqueUserNameLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    
    // MARK: - User
    
    var user: InstagramUser? = nil {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateUI() {
        if let user = self.user {
            self.fullUserNameLabel.text = user.fullName
            self.uniqueUserNameLabel.text = user.username
            self.userImageView.setImageWithURL(user.profilePictureURL)
        }
    }

}
