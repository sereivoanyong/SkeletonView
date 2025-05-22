//
//  UICollectionView+CollectionSkeleton.swift
//  SkeletonView-iOS
//
//  Created by Juanpe Catalán on 02/02/2018.
//  Copyright © 2018 SkeletonView. All rights reserved.
//

import UIKit
 
extension UICollectionView: CollectionSkeleton {

    var estimatedNumberOfRows: Int {
        guard let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout else { return 0 }
        switch flowlayout.scrollDirection {
        case .vertical:
            return Int(ceil(frame.height / flowlayout.itemSize.height))
        case .horizontal:
            return Int(ceil(frame.width / flowlayout.itemSize.width))
        default:
            return 0
        }
    }
    
    var skeletonDataSource: SkeletonCollectionDataSource? {
        get { return ao_object(forKey: &CollectionAssociatedKeys.dummyDataSource) as? SkeletonCollectionDataSource }
        set {
            ao_setObject(newValue, forKey: &CollectionAssociatedKeys.dummyDataSource)
            self.dataSource = newValue
        }
    }
    
    var skeletonDelegate: SkeletonCollectionDelegate? {
        get { return ao_object(forKey: &CollectionAssociatedKeys.dummyDelegate) as? SkeletonCollectionDelegate }
        set {
          ao_setObject(newValue, forKey: &CollectionAssociatedKeys.dummyDelegate)
            self.delegate = newValue
        }
    }
    
    func addDummyDataSource() {
        guard let originalDataSource = self.dataSource as? SkeletonCollectionViewDataSource,
            !(originalDataSource is SkeletonCollectionDataSource)
            else { return }
        
        let dataSource = SkeletonCollectionDataSource(collectionViewDataSource: originalDataSource)
        self.skeletonDataSource = dataSource
        reloadData()
    }
    
    func updateDummyDataSource() {
        if (dataSource as? SkeletonCollectionDataSource) != nil {
            reloadData()
        } else {
            addDummyDataSource()
        }
    }
    
    func removeDummyDataSource(reloadAfter: Bool) {
        guard let dataSource = self.dataSource as? SkeletonCollectionDataSource else { return }
        self.skeletonDataSource = nil
        self.dataSource = dataSource.originalCollectionViewDataSource
        if reloadAfter { self.reloadData() }
    }
    
}
