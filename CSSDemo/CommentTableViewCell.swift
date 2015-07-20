//
//  CommentTableViewCell.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 18.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit
import InstagramKit
import AFNetworking

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorFullNameLabel: UILabel!
    @IBOutlet weak var commentDateLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    
    // MARK: - Comment
    
    var comment: InstagramComment? = nil {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - DateFormatter
    
    static var dateFormatter: NSDateFormatter! = nil
    
    // MARK: - UITableViewCell

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - 
    
    func updateUI() {
        if let comment = self.comment {
            self.authorImageView.setImageWithURL(comment.user.profilePictureURL)
            self.authorFullNameLabel.text = comment.user.fullName
            self.commentTextLabel.text = comment.text
            
            if self.dynamicType.dateFormatter == nil {
                self.dynamicType.dateFormatter = NSDateFormatter()
                self.dynamicType.dateFormatter.dateFormat = "dd.MM.yyyy"
            }
            self.commentDateLabel.text = self.dynamicType.dateFormatter.stringFromDate(comment.createdDate)
            
            self.layoutIfNeeded()
        }
    }

}
