//
//  TrendingCell.swift
//  Youtube
//
//  Created by linshun on 31/7/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit
class TrendingCell: FeedCell {
    override func fetchVideos() {
      APIService.sharedInstance.fetchTrendingVideos { (videos:[Video]) in
         self.videos = videos
         self.collectionView.reloadData()
      }
       
    }
}
