//
//  ArticleResponse.swift
//  J2TTDemo
//
//  Created by Sagar on 25/07/20.
//  Copyright © 2020 Sagar. All rights reserved.
//

import Foundation
import ObjectMapper

public struct ArticleResponse {
    public var articleId: String?
    public var createdAt: String?
    public var content: String?
    public var comments: Int?
    public var likes: Int?
    public var mediaDetails: [Media]?
    public var userDetails: [User]?

}

extension ArticleResponse: ImmutableMappable {
    public init(map: Map) {
        articleId = try? map.value("id")
        createdAt = try? map.value("createdAt")
        content = try? map.value("content")
        comments = try? map.value("comments")
        likes = try? map.value("likes")
        mediaDetails = try? map.value("media")
        userDetails = try? map.value("user")
    }
    
    public func mapping(map: Map) {
        articleId >>> map["id"]
        createdAt >>> map["createdAt"]
        content >>> map["content"]
        comments >>> map["comments"]
        likes >>> map["likes"]
        mediaDetails >>> map["media"]
        userDetails >>> map["user"]
    }
}

public struct Media {
    public var mediaId: String?
    public var blogId: String?
    public var createdAt: String?
    public var image: String?
    public var title: String?
    public var url: String?
}

extension Media: ImmutableMappable {
    public init(map: Map) {
        mediaId = try? map.value("id")
        blogId = try? map.value("blogId")
        createdAt = try? map.value("createdAt")
        image = try? map.value("image")
        title = try? map.value("title")
        url = try? map.value("url")
    }
    
    public func mapping(map: Map) {
        mediaId >>> map["id"]
        blogId >>> map["blogId"]
        createdAt >>> map["createdAt"]
        image >>> map["image"]
        url >>> map["url"]
        title >>> map["title"]
    }
}

public struct User {
    public var mediaId: String?
    public var blogId: String?
    public var createdAt: String?
    public var userAvatar: String?
    public var name: String?
    public var userLastName: String?
    public var city: String?
    public var designation: String?
    public var about: String?
}

extension User: ImmutableMappable {
    public init(map: Map) {
        mediaId = try? map.value("id")
        blogId = try? map.value("blogId")
        createdAt = try? map.value("createdAt")
        userAvatar = try? map.value("avatar")
        name = try? map.value("name")
        userLastName = try? map.value("lastname")
        city = try? map.value("city")
        designation = try? map.value("designation")
        about = try? map.value("about")
    }
    
    public func mapping(map: Map) {
        mediaId >>> map["id"]
        blogId >>> map["blogId"]
        createdAt >>> map["createdAt"]
        userAvatar >>> map["avatar"]
        userLastName >>> map["lastname"]
        name >>> map["name"]
        city >>> map["city"]
        designation >>> map["designation"]
        about >>> map["about"]
    }
}

