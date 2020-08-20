//
//  playbackCell.swift
//  Youtube
//
//  Created by linshun on 20/8/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit
class PlaybackCell:BaseCell
    
{
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.darkGray : UIColor.white
            playbackLabel.textColor = isSelected ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = isSelected ? UIColor.white : UIColor.darkGray
            
        }
    }
    override var isHighlighted: Bool
        {
        didSet
        {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            
            playbackLabel.textColor = isHighlighted ? UIColor.white : UIColor.black
            
            iconImageView.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    let playbackLabel:UILabel = {
        let label = UILabel()
        label.text = "Setting"
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    let iconImageView:UIImageView =
    {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cancel")!.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFill
        imageView.tintColor = .darkGray
        return imageView
    }()
    
    var playback: Playback?
    {
        didSet
        {
            playbackLabel.text = playback?.playbackSpeed.stringValue
            
        }
    }
    override func setupViews() {
        super.setupViews()
        addSubview(playbackLabel)
        addSubview(iconImageView)
        addConstraintsWithFormat("H:|-50-[v0(30)]-8-[v1]|", views: iconImageView,playbackLabel)
        addConstraintsWithFormat("V:|[v0]|", views: playbackLabel)
        addConstraintsWithFormat("V:[v0(30)]", views: iconImageView)
        addConstraint(NSLayoutConstraint(item: iconImageView, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
        
        
    }
}
