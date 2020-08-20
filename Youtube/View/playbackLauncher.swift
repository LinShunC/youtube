//
//  playbackLauncher.swift
//  Youtube
//
//  Created by linshun on 20/8/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit

class PlaybackLauncher: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    let blackView = UIView()
     var videoPlayerView :VideoPlayerView?
     let collectionView : UICollectionView =
     {
         let layout = UICollectionViewFlowLayout()
         let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
         cv.backgroundColor = .white
         return cv
     }()
     let cellId = "cellId"
     let cellHeight:CGFloat = 40
     let playback :[Playback] =
     {
        let firstPlayback = Playback(playbackSpeed: 0.5)
         let secondPlayback  = Playback(playbackSpeed: 0.75)
         let thirdPlayback = Playback(playbackSpeed: 1)
        let fourthPlayback = Playback(playbackSpeed: 1.25)
        let fifthPlayback = Playback(playbackSpeed: 1.5)
         return [firstPlayback,secondPlayback,thirdPlayback,fourthPlayback,fifthPlayback]
     }()
    
    func showPlayback()
     {
         if let window = UIApplication.shared.keyWindow{
             
             blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
             blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
             window.addSubview(blackView)
             blackView.frame = window.frame
             blackView.alpha = 0
             
             window.addSubview(collectionView)
             let height:CGFloat = CGFloat(playback.count) * cellHeight
             let y = window.frame.height - height
             collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
             
             UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                 self.blackView.alpha = 1
                 self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
             }, completion: nil)
             
         }
         
         
     }
    @objc func handleTapDismiss() {
             UIView.animate(withDuration: 0.5) {
                 self.blackView.alpha = 0
                 
                 if let window = UIApplication.shared.keyWindow {
                     self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                 }
             }
         }
    @objc func handleDismiss(playback:Playback)
       {
              UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:  .curveEaseOut, animations: {
                           self.blackView.alpha = 0
                      if let window = UIApplication.shared.keyWindow
                      {
                          self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                      }
               }) { (completed:Bool) in
                   

                       self.videoPlayerView?.changePlayback(playback: playback)
               }
       }
     override init() {
            super.init()
            
            collectionView.dataSource  = self
            collectionView.delegate = self
            
        collectionView.register(PlaybackCell.self, forCellWithReuseIdentifier: cellId)
            let selectedIndexPath = IndexPath(item: 2, section: 0)
            collectionView.selectItem(at: selectedIndexPath, animated: false, scrollPosition: .bottom)
        }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return playback.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as!PlaybackCell
               let cellPlayback = playback[indexPath.item]
        cell.playback = cellPlayback
        
               return cell
               
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
                return CGSize(width: collectionView.frame.width, height: cellHeight)

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          let playback = self.playback[indexPath.item]
        handleDismiss(playback: playback)


    }
   
}
