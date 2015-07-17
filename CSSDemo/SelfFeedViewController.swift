//
//  MasterViewController.swift
//  CSSDemo
//
//  Created by Vjacheslav Volodko on 15.07.15.
//  Copyright (c) 2015 Vjacheslav Volodko. All rights reserved.
//

import UIKit
import InstagramKit

class SelfFeedViewController: UICollectionViewController {

    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let layout = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            let size = (self.view.bounds.size.width - 2 * layout.minimumInteritemSpacing) / 3.0
            layout.itemSize = CGSizeMake(size, size)
        }
        
        if InstagramEngine.sharedEngine().isSessionValid() {
            self.loadNextPage()
        } else {
            self.performSegueWithIdentifier("showLogin", sender: self)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Instagram data
    
    private let pageSize = 20
    private var mediaObjects: [InstagramMedia] = []
    private var paginationInfo: InstagramPaginationInfo? = nil
    
    
    private func hasNextPage() -> Bool {
        return self.paginationInfo != nil || self.mediaObjects.count == 0
    }
    
    private func loadNextPage() {
        if !self.hasNextPage() {
            return
        }
        
        InstagramEngine.sharedEngine().getSelfRecentMediaWithCount(self.pageSize,
            maxId: self.paginationInfo?.nextMaxId,
            success: { (media: [AnyObject]!, paginationInfo: InstagramPaginationInfo!) -> Void in
                NSLog("Got \(media.count) media: \(media)")
                for mediaObject in media {
                    self.mediaObjects.append(mediaObject as! InstagramMedia)
                }
                self.paginationInfo = paginationInfo
                self.collectionView?.reloadData()
            })
            { (error: NSError!, statusCode: Int) -> Void in
                NSLog("Error: \(error), statusCode: \(statusCode)")
            }
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow() {
//                let object = objects[indexPath.row] as! NSDate
//                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
//                controller.detailItem = object
//                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
//                controller.navigationItem.leftItemsSupplementBackButton = true
//            }
        }
    }
    
    @IBAction func unwindFromSegue(sender: UIStoryboardSegue?) {
        
    }

    // MARK: - Collection View Data Source
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.mediaObjects.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("SelfFeedCell", forIndexPath: indexPath) as! SelfFeedCollectionViewCell
        cell.media = self.mediaObjects[indexPath.row]
        return cell
    }
}

