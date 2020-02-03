//
//  PostsModel.swift
//  Bandana_Update_2
//
//  Created by Rakesh Nangunoori on 03/02/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import Foundation
class PostsModel {
    var title = String()
    var createdDate = String()
    var switchStatus = false
    init(dictionary: [String:Any]) {
        if let aTitle = dictionary[ServerKeys.titleKey] {
            self.title = aTitle as? String ?? ""
        }
        if let aCreatedDate = dictionary[ServerKeys.createdDate] {
            self.createdDate = aCreatedDate as? String ?? ""
        }
    }
    public class func getDicFromServerArray(array: [[String:Any]])->[PostsModel]{
        var posts = [PostsModel]()
        for eachObj in array{
            let modelObj = PostsModel.init(dictionary: eachObj)
            posts.append(modelObj)
        }
        return posts
    }
}
