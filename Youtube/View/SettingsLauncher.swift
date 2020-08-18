//
//  SettingsLauncher.swift
//  Youtube
//
//  Created by linshun on 22/7/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit
class Setting: NSObject {
    let name: SettingName?
    let imageName :String
    
    init(name:SettingName,imageName:String) {
        self.name = name
        self.imageName = imageName
    }
}


class SettingLauncher: NSObject,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    
    let blackView = UIView()
    let collectionView : UICollectionView =
    {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    let cellId = "cellId"
    let cellHeight:CGFloat = 50
    let settings :[Setting] =
    {
        let settingsSetting = Setting(name: .Settings, imageName: "settings")
        let cancelSetting  = Setting(name: .Cancel, imageName: "cancel")
        let termsPrivacySetting = Setting(name: .TermsPrivacy, imageName: "privacy")
        let feedbackSetting = Setting(name: .SendFeedback, imageName: "feedback")
        let helpSetting = Setting(name: .Help, imageName: "help")
        let switchAccountSetting = Setting(name: .SwitchAccount, imageName: "switch_account")
        return  [settingsSetting,termsPrivacySetting,feedbackSetting,helpSetting,switchAccountSetting,cancelSetting]
    }()
    
    var homeController :CollectionViewController?
    func showSettings()
    {
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapDismiss)))
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            
            window.addSubview(collectionView)
            let height:CGFloat = CGFloat(settings.count) * cellHeight
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
    @objc func handleDismiss(setting:Setting)
    {
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options:  .curveEaseOut, animations: {
                        self.blackView.alpha = 0
                   if let window = UIApplication.shared.keyWindow
                   {
                       self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                   }
            }) { (completed:Bool) in
                if setting.name != .Cancel{

                    self.homeController?.showControllerForSetting(setting: setting)}
            }
    }
    override init() {
        super.init()
        
        collectionView.dataSource  = self
        collectionView.delegate = self
        
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: cellId)
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingCell
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
  let setting = self.settings[indexPath.item]

        handleDismiss(setting: setting)
    
      
    }
}
