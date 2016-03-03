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
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var collectionView: UICollectionView!
    var bodyProgressImages = [CKRecord]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeNavigationBarHairline()
        formatNavigationBarTitle()
        fetchPhotos()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    func removeNavigationBarHairline() {
        for parent in navigationBar.subviews {
            for childView in parent.subviews {
                if(childView is UIImageView) {
                    childView.removeFromSuperview()
                }
            }
        }
    }
    
    func formatNavigationBarTitle() {
        navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        navigationBar.tintColor = UIColor.whiteColor()
        navigationBar.topItem!.title = "PPL"
    }
    
    func fetchPhotos() {
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
        let height = (CGRectGetHeight(collectionView!.frame)/3)-1.0
        
        return CGSize(width: width, height: height)
    }
}
