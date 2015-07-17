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

        self.updateUI()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static var dateFormatter = NSDateFormatter() {
        didSet {
            dateFormatter.dateFormat = "dd:MM:yyyy"
        }
    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
