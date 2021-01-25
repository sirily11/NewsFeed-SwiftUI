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
    let pureText: String


    enum CodingKeys: String, CodingKey {
        case id, title, link, cover, feed_comments
        case newsPublisher = "news_publisher"
        case content, sentiment
        case postedTime = "posted_time"
        case publisher
        case pureText = "pure_text"

    }
}

struct NewsPublisher: Codable, Identifiable {
    let id: Int
    let name: String
}

extension NewsPublisher {
    init(from publisher: NewsPublisherDB) {
        id = publisher.id
        name = publisher.name
    }

    func toDB() -> NewsPublisherDB {
        return NewsPublisherDB(value: ["name": name, "id": id])
    }
}

extension Author {
    init(from author: AuthorDB) {
        username = author.username
    }

    func toDB() -> AuthorDB {
        return AuthorDB(value: ["username": username])
    }
}

extension Comment {
    init(from comment: CommentDB) {
        id = comment.id
        author = Author(from: comment.author!)
        self.comment = comment.comment
    }

    func toDB() -> CommentDB {
        let author = self.author.toDB()
        let commentDB = CommentDB(value: ["id": id, "comment": comment])
        commentDB.author = author
        return commentDB
    }

}

extension Feed {

    var postedTimeDate: Date {
        get {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            let date = dateFormatter.date(from: postedTime)!
            return date
        }
    }

    init(from feed: FeedDB) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"


        id = feed.id
        title = feed.title
        link = feed.link
        cover = feed.cover
        content = feed.content
        sentiment = feed.sentiment
        postedTime = dateFormatter.string(from: feed.postedTime)
        publisher = feed.publisher
        feed_comments = feed.feed_comments.map {
            comment in

            Comment(from: comment)
        }
        newsPublisher = NewsPublisher(from: feed.newsPublisher!)
        pureText = feed.pureText
    }

    func toDB() -> FeedDB {
        let feed = FeedDB(value: ["id": id, "title": title, "link": link, "cover": cover ?? "", "content": content ?? "", "sentiment": sentiment ?? 0, "postedTime": postedTimeDate, "publisher": self.publisher, "newsPublisher": newsPublisher.toDB(), "pureText": pureText])

        for comment in self.feed_comments {
            feed.feed_comments.append(comment.toDB())
        }

        return feed
    }

}

let a: NewsPublisher = NewsPublisher(id: 1, name: "abc")
