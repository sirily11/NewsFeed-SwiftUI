//
//  Feed.swift
//  NewsFeed
//
//  Created by 李其炜 on 10/26/19.
//  Copyright © 2019 李其炜. All rights reserved.
//

import Foundation

// MARK: - Comment
struct Comment: Codable, Identifiable {
    let author: Author
    let comment: String
    let id: Double

    enum CodingKeys: String, CodingKey {
        case author, comment, id
    }
}

// MARK: - Author
struct Author: Codable {
    let username: String
}


struct NetworkResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Feed]
}

struct Feed: Codable, Identifiable {
    let id: Int
    let title: String
    let link: String
    let cover: String?
    let newsPublisher: NewsPublisher
    let content: String?
    let sentiment: Double?
    let postedTime: String
    let publisher: Int
    let feed_comments: [Comment]

    enum CodingKeys: String, CodingKey {
        case id, title, link, cover, feed_comments
        case newsPublisher = "news_publisher"
        case content, sentiment
        case postedTime = "posted_time"
        case publisher

    }
}

struct NewsPublisher: Codable, Identifiable {
    let id: Int
    let name: String
}

let a: NewsPublisher = NewsPublisher(id: 1, name: "abc");
