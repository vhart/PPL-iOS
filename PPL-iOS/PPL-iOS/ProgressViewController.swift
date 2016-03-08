//
//  ProgressViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit
import CloudKit

class ProgressViewController: UIViewController {
    @IBOutlet weak var navigationbar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var bodyProgressImages = [CKRecord]()
    
    @IBOutlet weak var progressView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView.hidden = true
        removeNavigationBarHairline()
        formatNavigationBarTitle()
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.hidden = true
        tabBarController?.tabBar.hidden = false
        
        if Reachability.isConnectedToNetwork() {
            
            if !bodyProgressImages.isEmpty {
                bodyProgressImages.removeAll()
            }
            
            fetchPhotos()
            
        } else {
            print("No internet connection")
        }
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "viewImage" {
    //            navigationController?.navigationBar.hidden = false
    //            tabBarController?.tabBar.hidden = true
    //
    //            let imageViewController = segue.destinationViewController as! ImageViewController
    //
    //            imageViewController.bodyImageView.image = sender as? UIImage
    ////            imageViewController.date = date
    //
    //
    //        }
    //    }
    
    func removeNavigationBarHairline() {
        for parent in navigationbar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
    }
    
    func formatNavigationBarTitle() {
        navigationbar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationbar.tintColor = UIColor.whiteColor()
        navigationbar.topItem!.title = "PPL"
    }
    
    func fetchPhotos() {
        progressView.hidden = false
        view.bringSubviewToFront(progressView)
        
        let container = CKContainer.defaultContainer()
        let privateDatabase = container.privateCloudDatabase
        let predicate = NSPredicate(value: true)
        
        let query = CKQuery(recordType: "Images", predicate: predicate)
        
        privateDatabase.performQuery(query, inZoneWithID: nil) { (results, error) -> Void in
            if error != nil {
                print(error)
            }
            else {
                
                if let imageResults = results {
                    for result in imageResults {
                        self.bodyProgressImages.append(result)
                    }
                    
                    NSOperationQueue.mainQueue().addOperationWithBlock{
                        self.progressView.hidden = true
                        self.collectionView.reloadData()
                    }
                }
                
            }
        }
    }
    
    
    
}

extension ProgressViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bodyProgressImages.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("bodyProgressImageCell", forIndexPath: indexPath) as! BodyProgressCollectionViewCell
        
        let photoRecord = bodyProgressImages[indexPath.row]
        let date = photoRecord.valueForKey("workoutDate") as? String
        let imageAsset = photoRecord.valueForKey("workoutImage") as! CKAsset
        
        cell.dateLabel.text = date
        cell.imageView.image = UIImage(contentsOfFile: imageAsset.fileURL.path!)
        
        return cell
    }
    
    //    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    //        if let cell = self.collectionView.cellForItemAtIndexPath(indexPath) as? BodyProgressCollectionViewCell {
    //            let image = cell.imageView.image
    //            self.performSegueWithIdentifier("viewImage", sender: image)
    //        }
    //    }
    
}

// MARK: UICollectionViewDelegateFlowLayout
extension ProgressViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return itemSizeForCells()
    }
    
    func itemSizeForCells() -> CGSize
    {
        
        let width = (CGRectGetWidth(collectionView!.frame)/3)-1.0
        let height = (CGRectGetHeight(collectionView!.frame)/3)
        
        return CGSize(width: width, height: height)
    }
}
