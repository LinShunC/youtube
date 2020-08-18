//
//  Extensions.swift
//  youtube
//
//  Created by Brian Voong on 6/3/16.
//  Copyright © 2016 letsbuildthatapp. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            view.translatesAutoresizingMaskIntoConstraints = false
            viewsDictionary[key] = view
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}
let imageCache = NSCache<NSString, UIImage>()
class CustomImageView: UIImageView {
    // check cell load correct image
    var imageUrlString: String?

    func loadImageUsingUrlString(urlString: String) {
        
        imageUrlString = urlString
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
                   self.image = imageFromCache
                   return
               }
        
        let url = URL(string: urlString)!
        
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, respones, error) in
            
            if error != nil {
                print(error ?? "")
                return
            }
            
            DispatchQueue.main.async {
                let imageToCache = UIImage(data: data!)
                
                
                
                if self.imageUrlString == urlString {
                                  self.image = imageToCache
                              }
                              
                imageCache.setObject(imageToCache!, forKey: urlString as NSString)

            
                
            }
            
        }).resume()
    }
    
}
