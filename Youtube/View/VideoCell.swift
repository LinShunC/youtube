//
//  homeCell.swift
//  Youtube
//
//  Created by linshun on 16/7/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit
class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    func setupViews() {
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoCell: BaseCell {
    var video:Video?
    {
        didSet
        {
            titleLabel.text = video?.title
            setupThumbnailImage()
            setupProfileImage()
            
            
            
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            if let channelName = video?.channel?.name,  let numberOfViews = video?.numberOfViews
            {
                let numberFormatter = NumberFormatter()
                               numberFormatter.numberStyle = .decimal
                               
                let subtitleText = "\(channelName) • \(numberFormatter.string(from: NSNumber(value: numberOfViews))!) • 2 years ago "
                               subtitleTextView.text = subtitleText
                
          
            }
            // measure title text
            if let title = video?.title
            {
                let size = CGSize(width: frame.width - 16 - 44 - 8 - 16, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                
                let estimateRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)], context: nil)
                if estimateRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = 44
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
        }
    }
    func   setupThumbnailImage()
    {
        if let thumbnailImageUrl = video?.thumbnailImageName
    {
        thumbnailImageView.loadImageUsingUrlString(urlString: thumbnailImageUrl)
    }
        
    }
    func setupProfileImage()
    {
        
        if let profileImageUrl = video?.channel?.profileImageName
           {
            userProfileImageView.loadImageUsingUrlString(urlString: profileImageUrl)
           }
        
    }
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        //imageView.image = UIImage(named: "taylor_swift_blank_space")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        
        return view
    }()
    let userProfileImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
    //    imageView.image = UIImage(named: "profile")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        return imageView
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Taylor Swift - Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let subtitleTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = "TaylorSwiftVEVO • 1,604,684,607 views • 2 years ago"
        textView.textColor = UIColor.lightGray
        textView.textContainerInset = UIEdgeInsets(top: 0, left: -4, bottom: 0, right: 0)
        
        return textView
    }()
    
    var titleLabelHeightConstraint:NSLayoutConstraint?
    override func setupViews() {
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(subtitleTextView)
        
        
        addConstraintsWithFormat("H:|-16-[v0]-16-|", views: thumbnailImageView)
        
        addConstraintsWithFormat("H:|-16-[v0(44)]", views: userProfileImageView)
        
        //vertical constraints
        addConstraintsWithFormat("V:|-16-[v0]-8-[v1(44)]-36-[v2(1)]|", views: thumbnailImageView, userProfileImageView, separatorView)
        
        addConstraintsWithFormat("H:|[v0]|", views: separatorView)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .top, relatedBy: .equal, toItem: thumbnailImageView, attribute: .bottom, multiplier: 1, constant: 8))
        //left constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        
        titleLabelHeightConstraint = NSLayoutConstraint(item: titleLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 20)
        addConstraint(titleLabelHeightConstraint!)
        
        //top constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 4))
        //left constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .left, relatedBy: .equal, toItem: userProfileImageView, attribute: .right, multiplier: 1, constant: 8))
        //right constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .right, relatedBy: .equal, toItem: thumbnailImageView, attribute: .right, multiplier: 1, constant: 0))
        //height constraint
        addConstraint(NSLayoutConstraint(item: subtitleTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 30))
        
        /*  thumbnailImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
         
         thumbnailImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
         thumbnailImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
         thumbnailImageView.heightAnchor.constraint(equalToConstant: self.frame.height*0.5).isActive = true
         
         
         
         
         userProfileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
         userProfileImageView.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
         userProfileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
         userProfileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
         
         
         
         titleLabel.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 16).isActive = true
         titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
         titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 8).isActive = true
         titleLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
         
         
         subtitleTextView.leftAnchor.constraint(equalTo: userProfileImageView.rightAnchor, constant: 12).isActive = true
         subtitleTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
         subtitleTextView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4).isActive = true
         subtitleTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
         
         
         let separatorLineView = UIView()
         separatorLineView.backgroundColor = UIColor(red:0.86, green:0.86, blue:0.86, alpha:1.00)
         separatorLineView.translatesAutoresizingMaskIntoConstraints = false
         addSubview(separatorLineView)
         //x,y,w,h
         separatorLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
         separatorLineView.topAnchor.constraint(equalTo:topAnchor).isActive = true
         separatorLineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
         separatorLineView.heightAnchor.constraint(equalToConstant: 2).isActive = true
         addSubview(separatorLineView)*/
        
        
    }
    
    
    
}





