//
//  SelfDetailsViewController.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 21.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit
import InstagramKit
import AFNetworking

class UserDetailsViewController: UIViewController {
    
    // MARK: - User 
    
    var user: InstagramUser? = nil {
        didSet {
            self.updateUI()
        }
    }
    
    // MARK: - Subviews
    // MARK: Subviews Properties
    
    var userProfileImageView: UIImageView! = nil
    var fullNameLabel: UILabel! = nil
    var userNameLabel: UILabel! = nil
    var bioTextView: UITextView! = nil
    
    var mediaCounterView: IntCounterView! = nil
    var followsCounterView: IntCounterView! = nil
    var followedByCounterView: IntCounterView! = nil
    
    // MARK: Subviews Setup
    func setupSubviews() {
        self.view.cas_styleClass = "background"
        
        self.userProfileImageView = UIImageView()
        self.userProfileImageView.contentMode = .ScaleAspectFill
        self.userProfileImageView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userProfileImageView.cas_styleClass = "avatar-big"
        self.view.addSubview(self.userProfileImageView)
        
        self.fullNameLabel = UILabel()
        self.fullNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.fullNameLabel.cas_styleClass = "fullname"
        self.view.addSubview(self.fullNameLabel)
        
        self.userNameLabel = UILabel()
        self.userNameLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.userNameLabel.cas_styleClass = "username"
        self.view.addSubview(self.userNameLabel)
        
        self.bioTextView = UITextView()
        self.bioTextView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.bioTextView.editable = false
        self.bioTextView.dataDetectorTypes = .Link
        self.bioTextView.textContainerInset = UIEdgeInsetsZero
        self.bioTextView.textContainer.lineFragmentPadding = 0;
        self.bioTextView.cas_styleClass = "text"
        self.view.addSubview(self.bioTextView)
        
        
        self.mediaCounterView = IntCounterView()
        self.mediaCounterView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.mediaCounterView.title = "Media:"
        self.view.addSubview(self.mediaCounterView)
        
        self.followsCounterView = IntCounterView()
        self.followsCounterView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followsCounterView.title = "Follows:"
        self.view.addSubview(self.followsCounterView)
        
        self.followedByCounterView = IntCounterView()
        self.followedByCounterView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.followedByCounterView.title = "Followed by:"
        self.view.addSubview(self.followedByCounterView)
    }
    
    // MARK: Subviews Layout
    func setupLayout() {
        let views: [NSObject : AnyObject] = [
            "userProfileImageView" : self.userProfileImageView,
            "fullNameLabel" : self.fullNameLabel,
            "userNameLabel" : self.userNameLabel,
            "bioTextView" : self.bioTextView,
            
            "mediaCounterView" : self.mediaCounterView,
            "followsCounterView" : self.followsCounterView,
            "followedByCounterView" : self.followedByCounterView,
            ]
        
        let metrics: [NSObject : AnyObject] = [
            "offset" : 20,
            "smallOffset" : 4,
            "userImageSize" : 150,
            ]
        
        let imageToFullNameConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-offset-[userProfileImageView(userImageSize)]-[fullNameLabel]-(>=offset)-|",
            options: NSLayoutFormatOptions.allZeros, metrics: metrics,views: views)
        self.view.addConstraints(imageToFullNameConstraints)
        
        let imageToBioConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-offset-[userProfileImageView(userImageSize)]-offset-[bioTextView]-offset-|",
            options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views)
        self.view.addConstraints(imageToBioConstraints)
        
        let bioConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|-offset-[bioTextView]-offset-|",
            options: NSLayoutFormatOptions.allZeros, metrics: metrics, views: views)
        self.view.addConstraints(bioConstraints)
        
        let fullNameToUserNameToCountersConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:|-offset-[fullNameLabel]-smallOffset-[userNameLabel]-smallOffset-[mediaCounterView]-smallOffset-[followsCounterView]-smallOffset-[followedByCounterView]",
            options: NSLayoutFormatOptions.AlignAllLeft, metrics: metrics, views: views)
        self.view.addConstraints(fullNameToUserNameToCountersConstraints)
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupSubviews()
        self.setupLayout()
        self.updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    
    func updateUI() {
        if !self.isViewLoaded() {
            return
        }
        
        if let user = self.user {
            self.title = "Profile: \(user.username)"
            self.fullNameLabel.text = user.fullName
            self.userNameLabel.text = user.username
            
            let infoTuple = (user.bio, user.website.absoluteString)
            var infoString: String = ""
            switch infoTuple {
            case (let bio, nil) :
                infoString = bio
            case (nil, let website) where website != nil:
                infoString = website!
            case (let bio, let website):
                infoString = "\(bio)\n\(website!)"
            }
            self.bioTextView.text = infoString
            
            self.userProfileImageView.setImageWithURL(user.profilePictureURL)
            
            self.mediaCounterView.count = user.mediaCount
            self.followsCounterView.count = user.followsCount
            self.followedByCounterView.count = user.followedByCount
        }
    }

}
