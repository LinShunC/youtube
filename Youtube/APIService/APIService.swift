//
//  APIService.swift
//  Youtube
//
//  Created by linshun on 28/7/20.
//  Copyright © 2020 lin shun. All rights reserved.
//

import UIKit

class APIService: NSObject {
static let sharedInstance = APIService()
        let baseUrl = "https://s3-us-west-2.amazonaws.com/youtubeassets"
    func fetchVideos(completion: @escaping ([Video]) -> ())
      {
           fetchFeedForUrlString(urlString: "\(baseUrl)/home.json", completion: completion)
      }
    
    func fetchTrendingVideos(completion: @escaping ([Video]) -> ())
      {
     fetchFeedForUrlString(urlString: "\(baseUrl)/trending.json", completion: completion)

      }
    
    func fetchSubscriptionVideos(completion: @escaping ([Video]) -> ())
        {
                  fetchFeedForUrlString(urlString: "\(baseUrl)/subscriptions.json", completion: completion)


        }

    
    func fetchFeedForUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
           let url = URL(string: urlString)
           URLSession.shared.dataTask(with: url!) { (data, response, error) in
               
               if error != nil {
                   print(error ?? "")
                   return
               }
               
               do {
              

                 
                guard let data = data else { return }
                              let decoder = JSONDecoder()
                              decoder.keyDecodingStrategy = .convertFromSnakeCase
                              let videos = try decoder.decode([Video].self, from: data)

                              DispatchQueue.main.async {
                                  completion(videos)
                              }

               } catch let jsonError {
                   print(jsonError)
               }
               
               
               
               }.resume()
       }
       
}
//let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
//
//               var videos = [Video]()
//
//               for dictionary in json as! [[String: AnyObject]] {
//
//                   let video = Video()
//                   video.title = dictionary["title"] as? String
//                   video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
//
//                   let channelDictionary = dictionary["channel"] as! [String: AnyObject]
//
//                   let channel = Channel()
//                   channel.name = channelDictionary["name"] as? String
//                   channel.profileImageName = channelDictionary["profile_image_name"] as? String
//
//                   video.channel = channel
//
//                   videos.append(video)
//               }
//
//               DispatchQueue.main.async {
//                   completion(videos)
//               }
