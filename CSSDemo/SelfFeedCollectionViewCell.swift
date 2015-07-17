//
//  SelfFeedCollectionViewCell.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 17.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit
import InstagramKit
import AFNetworking

class SelfFeedCollectionViewCell: UICollectionViewCell {
    
    // Mark: - IBOutlets
    
    @IBOutlet private weak var mediaThumbnailImageView: UIImageView!
    
    
    // Mark: - Media Object
    
    var media: InstagramMedia? = nil {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        if let media = self.media {
            self.mediaThumbnailImageView.setImageWithURL(media.thumbnailURL)
        }
    }
    
    
}
