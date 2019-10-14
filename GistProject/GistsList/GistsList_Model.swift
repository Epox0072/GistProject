//
//  GistsList_Model.swift
//  GistProject
//
//  Created by Stanislav on 26/09/2019.
//  Copyright © 2019 Stanislav. All rights reserved.
//

import UIKit



struct GistsList_Model {
    var owner : Dictionary<String, Any>
    var userName : String
    var userAvatarURL : String
    var postDate : String
    
    init(_ dictionary : Dictionary<String, Any>) {
        self.postDate = dictionary["created_at"] as? String ?? ""
        self.owner = dictionary["owner"] as? Dictionary<String, Any> ?? [:]
        if let userName = self.owner["login"] as? String {
            self.userName = userName;
        } else {self.userName = ""}
        if let userAvatarUrl = self.owner["avatar_url"] as? String {
            self.userAvatarURL = userAvatarUrl
        } else {self.userAvatarURL = ""}
    }
}
