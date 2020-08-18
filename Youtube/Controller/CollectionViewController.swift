//
//  CollectionViewController.swift
//  Youtube
//
//  Created by linshun on 16/7/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"
private let trendingCellID = "trendingCell"
private let subscriptionCellID = "subscriptionCell"
class CollectionViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {
   
   
   var videos:[Video]?

   let titles = ["Home","Trending","Subscriptions","Account"]
   
   
   override func viewDidLoad() {
      super.viewDidLoad()
  
      
      
      setupCollectionView()
      
      navigationController?.navigationBar.barTintColor =   UIColor.rgb(red: 230, green: 32, blue: 31)
      navigationController?.navigationBar.isTranslucent = false
      
      // clear the line between tab bar and navigation bar
      navigationController?.navigationBar.shadowImage = UIImage()
      navigationController?.navigationBar.backgroundImage(for: .default)
      
      
      
      
      let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
      titleLabel.text = "  Home"
      titleLabel.textColor = .white
      titleLabel.font = UIFont.systemFont(ofSize: 20)
      navigationItem.titleView = titleLabel
      setupMenuBar()
      setupNavBarButtons()
   }
   func setupCollectionView() {
      if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
      {
         flowLayout.scrollDirection = .horizontal
         flowLayout.minimumLineSpacing = 0
      }
      collectionView.isPagingEnabled = true
      collectionView?.backgroundColor = .white
      
      collectionView.register(FeedCell.self, forCellWithReuseIdentifier: reuseIdentifier)
      collectionView.register(TrendingCell.self, forCellWithReuseIdentifier: trendingCellID)
      collectionView.register(SubscriptionCell.self, forCellWithReuseIdentifier: subscriptionCellID)
      
      // make sure the content is under the menu bar
      collectionView.contentInset = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
      collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50,left: 0,bottom: 0,right: 0)
   }
   func scrollToMenuIndex(menuIndex: Int) {
      let indexPath = IndexPath(item: menuIndex, section: 0)
      collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
      setTitleForIndex(index: menuIndex)
      
   }
   private func setTitleForIndex(index:Int)
   {
      if let titleLabel =  navigationItem.titleView as? UILabel
      {
         titleLabel.text = "  \(titles[index])"
      }
   }
   override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
      let index = Int(targetContentOffset.pointee.x / view.frame.width)
      let indexPath = IndexPath(item: index, section: 0)
      menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
      setTitleForIndex(index: Int(index))
   }
   override func scrollViewDidScroll(_ scrollView: UIScrollView) {
      //print(scrollView.contentOffset.x)
      menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
   }
   lazy var menuBar :MenuBar = {
      let mb = MenuBar()
      mb.collectionViewController = self
      return mb
   }()
   
   func setupNavBarButtons()
   {
      let searchImage  = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
      let searchBarButtonItem = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
      
      let moreButton = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleMore))
      navigationItem.rightBarButtonItems = [moreButton,searchBarButtonItem]
      
   }
   @objc func handleSearch()
   {
      print(123)
   }
   lazy var settingsLauncher : SettingLauncher =
      {
         let launcher = SettingLauncher()
         launcher.homeController = self
         return launcher
   }()
   @objc func handleMore()
   {
      settingsLauncher.showSettings()
   }
   func showControllerForSetting(setting:Setting)
   {
      let dummySettingViewController = UIViewController()
      dummySettingViewController.navigationItem.title = setting.name?.rawValue
      dummySettingViewController.view.backgroundColor = .white
      navigationController?.navigationBar.tintColor = .white
      navigationController?.navigationBar.titleTextAttributes  = [NSAttributedString.Key.foregroundColor: UIColor.white]
      navigationController?.pushViewController( dummySettingViewController, animated: true)
   }
   
   private func  setupMenuBar()
   {
      // hide when Swipe
      navigationController?.hidesBarsOnSwipe = true
      
      let redView = UIView()
      redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
      view.addSubview(redView)
      view.addConstraintsWithFormat("H:|[v0]|", views: redView)
      view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
      
      
      view.addSubview(menuBar)
      view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
      view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
      
      menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
      
   }
   
   override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return 4
   }
   override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
      
      let identifier: String
      
      if indexPath.item == 1 {
         identifier = trendingCellID
      }
      else if  indexPath.item == 2
      {
         identifier = subscriptionCellID
      }
         
      else {
         identifier = reuseIdentifier
      }
      
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
      
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      return CGSize(width: view.frame.width, height: view.frame.height)
   }
   
}
