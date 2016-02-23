//
//  LoggingCollectionViewController.swift
//  PPL-iOS
//
//  Created by Jovanny Espinal on 2/22/16.
//  Copyright © 2016 Jovanny Espinal. All rights reserved.
//

import UIKit

class LoggingCollectionViewController: UICollectionViewController {
    var workoutLog: WorkoutLog?
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 2
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("WorkoutLogCell", forIndexPath: indexPath) as! LoggingCollectionViewCell
        
        cell.layer.cornerRadius = 5.0
        cell.layer.masksToBounds = true
        cell.formatButtons()

        
        return cell
    }


}

extension LoggingCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            
            return itemSizeForCells()
    }
    
    func itemSizeForCells() -> CGSize {
        let leftAndRightPaddings: CGFloat = 8.0
        
        let width = (CGRectGetWidth(collectionView!.frame) - leftAndRightPaddings)
        let height = (CGRectGetHeight(collectionView!.frame)/6)
        
        return CGSize(width: width, height: height)
        
        
    }
}