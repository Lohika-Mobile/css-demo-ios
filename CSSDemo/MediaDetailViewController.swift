//
//  MediaDetailViewController.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 18.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit
import InstagramKit
import AFNetworking

class MediaDetailViewController: UIViewController {

    /// MARK: - IBOutlets
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var likesCountLabel: UILabel!
    @IBOutlet private weak var commentCountLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    
    /// MARK: - Instagram media
    
    var media: InstagramMedia? = nil {
        didSet {
            self.updateUI()
        }
    }
    
    /// MARK: - UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.dynamicType.dateFormatter == nil {
            self.dynamicType.dateFormatter = NSDateFormatter()
            self.dynamicType.dateFormatter.dateFormat = "dd.MM.yyyy"
        }

        self.updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static var dateFormatter: NSDateFormatter! = nil
    
    func updateUI() {
        if !self.isViewLoaded() {
            return
        }
        
        if let media = self.media {
            self.imageView.setImageWithURL(media.standardResolutionImageURL)
            self.captionLabel.text = media.caption.text
            self.likesCountLabel.text = "\(media.likesCount)"
            self.commentCountLabel.text = "\(media.commentCount)"
            self.dateLabel.text = self.dynamicType.dateFormatter.stringFromDate(media.createdDate)
        }
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLikes" {
            if let likesController = segue.destinationViewController as? LikesViewController,
                likedUsers = self.media?.likes as? [InstagramUser] {
                    likesController.likedUsers = likedUsers
            }
        } else if segue.identifier == "showComments" {
            if let commentsController = segue.destinationViewController as? CommentsViewController,
                comments = self.media?.comments as? [InstagramComment] {
                    commentsController.comments = comments
            }
        }
    }

}
