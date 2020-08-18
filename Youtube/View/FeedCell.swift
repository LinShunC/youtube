//
//  FeedCell.swift
//  Youtube
//
//  Created by linshun on 30/7/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit

class FeedCell: BaseCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var videos:[Video]?
    let cellId = "cellId"
    
    lazy var collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        cv.dataSource = self
       cv.delegate = self
        return cv
    }()
    
    func fetchVideos()
    {
       APIService.sharedInstance.fetchVideos { (videos:[Video]) in
          self.videos = videos
          self.collectionView.reloadData()
       }
    }
    override func setupViews() {
        super.setupViews()
        fetchVideos()
        backgroundColor = .brown
        addSubview(collectionView)
        addConstraintsWithFormat("H:|[v0]|", views: collectionView)
        addConstraintsWithFormat("V:|[v0]|", views: collectionView)
        collectionView.register(VideoCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInset = .init(top: 50, left: 0, bottom: 0, right: 0)
               collectionView.scrollIndicatorInsets = .init(top: 50, left: 0, bottom: 0, right: 0)

    }
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         //  #warning Incomplete implementation, return the number of items
                if let count = videos?.count
                {
                   return count
                }
                return 0
          return videos?.count ?? 0
       }
    
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! VideoCell
    
          cell.video = videos?[indexPath.item]
    
    
          return cell
       }
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
          return 0
       }
    
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          let height = (frame.width - 16 - 16) * 9 / 16
          // height plus vertical constraints to make sure it is 16:9
          return CGSize(width: frame.width, height: height + 16 + 88)
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(123)
        let videoLauncher = VideoLauncher()
        videoLauncher.showVideoPlayer()
    }
}
